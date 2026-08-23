#!/bin/bash
# RUN command ./bedrock-access-check.sh
# Set colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to validate JSON response
validate_model_response() {
    local response_file="$1"
    local model_name="$2"
    
    if [[ ! -f "$response_file" ]]; then
        echo -e "${RED}❌ Response file not found${NC}"
        return 1
    fi
    
    # Check if response contains valid JSON
    if ! jq empty "$response_file" 2>/dev/null; then
        echo -e "${RED}❌ Invalid JSON response${NC}"
        echo "Raw response:"
        cat "$response_file"
        return 1
    fi
    
    # Check for error in response
    local error_msg=$(jq -r '.error.message // empty' "$response_file" 2>/dev/null)
    if [[ -n "$error_msg" ]]; then
        echo -e "${RED}❌ Model returned error: $error_msg${NC}"
        return 1
    fi
    
    # Extract and validate content
    local content=$(jq -r '.content[0].text // empty' "$response_file" 2>/dev/null)
    if [[ -z "$content" ]]; then
        echo -e "${YELLOW}⚠️  Response format may be different than expected${NC}"
        echo "Full response:"
        cat "$response_file" | jq 2>/dev/null || cat "$response_file"
        return 1
    fi
    
    echo -e "${GREEN}✅ Valid response received from $model_name${NC}"
    echo -e "${CYAN}📝 Response content:${NC}"
    echo "$content"
    return 0
}

# Function to check for access denied errors in JSON output
check_access_denied() {
    local file="$1"
    local message="$2"
    
    if [[ ! -f "$file" ]]; then
        return 0
    fi
    
    if grep -q "AccessDenied\|UnauthorizedOperation\|AuthorizationError" "$file" 2>/dev/null; then
        echo -e "${RED}❌ Access denied: $message${NC}"
        echo -e "${YELLOW}ℹ️  You may need additional IAM permissions:${NC}"
        echo "   - servicequotas:ListServiceQuotas"
        echo "   - servicequotas:GetServiceQuota"
        echo "   - servicequotas:ListAWSDefaultServiceQuotas"
        return 1
    fi
    
    return 0
}

echo -e "${BLUE}🔐 Setting AWS Profile and Verifying Identity...${NC}"
export AWS_PROFILE=default
aws sts get-caller-identity --no-cli-pager

echo ""
echo -e "${BLUE}👤 Checking AWS Configuration...${NC}"
aws configure list --no-cli-pager

echo ""
echo -e "${BLUE}🔐 Verifying IAM user policies (attached)...${NC}"
aws iam list-attached-user-policies --user-name textract-api-user \
  --query "AttachedPolicies[].PolicyName" --no-cli-pager

echo ""
echo -e "${BLUE}🛠 Verifying IAM user inline policies...${NC}"
aws iam list-user-policies --user-name textract-api-user \
  --query "PolicyNames" --no-cli-pager

echo ""
echo -e "${BLUE}📦 Listing available Claude models...${NC}"
echo "Available Claude models in us-west-2:"
aws bedrock list-foundation-models \
  --region us-west-2 \
  --query "modelSummaries[?providerName=='Anthropic' && contains(modelId, 'claude')].modelId" \
  --output text \
  --no-paginate --no-cli-pager | tr '\t' '\n' | sort

echo ""
echo -e "${CYAN}🎯 EXPLICIT CHECK: Claude 3.5 Sonnet V2 Availability${NC}"
echo -e "${YELLOW}🔍 Checking Claude 3.5 Sonnet V2 models specifically...${NC}"

# V2 models to check explicitly
v2_models=(
  "anthropic.claude-3-5-sonnet-20241022-v2:0"
  "anthropic.claude-3-5-sonnet-20241022-v2:0:18k"
  "anthropic.claude-3-5-sonnet-20241022-v2:0:51k"
  "anthropic.claude-3-5-sonnet-20241022-v2:0:200k"
)

v2_available=false
for model in "${v2_models[@]}"; do
  echo ""
  echo -e "${CYAN}📊 V2 Model: ${model}${NC}"
  if aws bedrock get-foundation-model-availability \
    --region us-west-2 \
    --model-id "$model" \
    --query '{ModelId: modelId, AuthStatus: authorizationStatus, EntitlementAvail: entitlementAvailability, AgreementAvail: agreementAvailability}' \
    --output table --no-cli-pager 2>/dev/null; then
    
    # Check if the model is actually available
    auth_status=$(aws bedrock get-foundation-model-availability \
      --region us-west-2 \
      --model-id "$model" \
      --query 'authorizationStatus' \
      --output text --no-cli-pager 2>/dev/null)
    
    entitlement_status=$(aws bedrock get-foundation-model-availability \
      --region us-west-2 \
      --model-id "$model" \
      --query 'entitlementAvailability' \
      --output text --no-cli-pager 2>/dev/null)
    
    if [[ "$auth_status" == "AUTHORIZED" && "$entitlement_status" == "AVAILABLE" ]]; then
      echo -e "${GREEN}✅ V2 Model is FULLY AVAILABLE${NC}"
      v2_available=true
    else
      echo -e "${YELLOW}⚠️  V2 Model found but not fully available (Auth: $auth_status, Entitlement: $entitlement_status)${NC}"
    fi
  else 
    echo -e "${RED}❌ V2 Model not found or accessible${NC}"
  fi
done

echo ""
echo -e "${CYAN}📊 QUOTA INFORMATION${NC}"
echo -e "${YELLOW}🔍 Checking Bedrock service quotas...${NC}"

# Create temp files for quota output
quotas_file="/tmp/bedrock_quotas.json"
default_quotas_file="/tmp/bedrock_default_quotas.json"

# Check Bedrock service quotas with improved error handling
echo "Current Bedrock Service Quotas:"
aws service-quotas list-service-quotas \
  --service-code bedrock \
  --no-cli-pager > "$quotas_file" 2>&1

if [ $? -eq 0 ] && [ -s "$quotas_file" ]; then
    # Check for access denied errors
    if check_access_denied "$quotas_file" "Cannot retrieve service quotas"; then
        # Filter and display quota information
        jq '.Quotas[] | select(.QuotaName | contains("Claude") or contains("On-Demand") or contains("Input") or contains("Output")) | {QuotaName, Value, Unit}' "$quotas_file" 2>/dev/null | \
        jq -r '. | "• " + .QuotaName + ": " + (.Value|tostring) + " " + .Unit' 2>/dev/null || \
        echo -e "${YELLOW}⚠️  No relevant quotas found or error parsing quota data${NC}"
    fi
else
    echo -e "${RED}❌ Failed to retrieve service quotas${NC}"
    echo -e "${YELLOW}ℹ️  Raw output:${NC}"
    cat "$quotas_file"
    echo -e "${YELLOW}ℹ️  You may need to add these permissions to your IAM policy:${NC}"
    echo "   - servicequotas:ListServiceQuotas"
    echo "   - servicequotas:GetServiceQuota"
fi

echo ""
echo -e "${YELLOW}🔍 Checking applied quotas for Claude models...${NC}"
aws service-quotas list-aws-default-service-quotas \
  --service-code bedrock \
  --no-cli-pager > "$default_quotas_file" 2>&1

if [ $? -eq 0 ] && [ -s "$default_quotas_file" ]; then
    # Check for access denied errors
    if check_access_denied "$default_quotas_file" "Cannot retrieve default service quotas"; then
        # Filter and display quota information
        jq '.Quotas[] | select(.QuotaName | contains("Claude")) | {QuotaName, Value, Unit}' "$default_quotas_file" 2>/dev/null | \
        jq -r '. | "• " + .QuotaName + ": " + (.Value|tostring) + " " + .Unit' 2>/dev/null || \
        echo -e "${YELLOW}⚠️  No Claude default quotas found or error parsing quota data${NC}"
    fi
else
    echo -e "${RED}❌ Failed to retrieve default service quotas${NC}"
    echo -e "${YELLOW}ℹ️  Raw output:${NC}"
    cat "$default_quotas_file"
    echo -e "${YELLOW}ℹ️  You may need to add this permission to your IAM policy:${NC}"
    echo "   - servicequotas:ListAWSDefaultServiceQuotas"
fi

# Alternative approach using describe-service-quotas
echo ""
echo -e "${YELLOW}🔍 Trying alternative approach for quota information...${NC}"
echo "Checking quota information using AWS CLI describe-service-quotas:"
aws bedrock describe-model-customization-job --job-name dummy-job 2>&1 | grep -i "quota\|limit\|rate" || \
echo -e "${YELLOW}⚠️  No quota information found using alternative approach${NC}"

echo ""
echo -e "${YELLOW}🔍 Checking specific model access status...${NC}"

# Array of models to check
models=(
  "anthropic.claude-3-5-sonnet-20240620-v1:0"
  "anthropic.claude-3-5-sonnet-20240620-v1:0:18k"
  "anthropic.claude-3-5-sonnet-20240620-v1:0:51k"
  "anthropic.claude-3-5-sonnet-20240620-v1:0:200k"
  "anthropic.claude-3-5-sonnet-20241022-v2:0"
  "anthropic.claude-3-5-sonnet-20241022-v2:0:18k"
  "anthropic.claude-3-5-sonnet-20241022-v2:0:51k"
  "anthropic.claude-3-5-sonnet-20241022-v2:0:200k"
  "anthropic.claude-sonnet-4-20250514-v1:0"
  "anthropic.claude-opus-4-20250514-v1:0"
)

for model in "${models[@]}"; do
  echo ""
  echo -e "${YELLOW}📊 Checking: ${model}${NC}"
  if aws bedrock get-foundation-model-availability \
    --region us-west-2 \
    --model-id "$model" \
    --query '{ModelId: modelId, AuthStatus: authorizationStatus, EntitlementAvail: entitlementAvailability, AgreementAvail: agreementAvailability}' \
    --output table --no-cli-pager 2>/dev/null; then
    echo -e "${GREEN}✅ Model details shown above${NC}"
  else
    echo -e "${RED}❌ Model not found or accessible${NC}"
  fi
done

echo ""
echo -e "${GREEN}🚦 ENHANCED MODEL TESTING WITH VALIDATION${NC}"

# Create test input
cat > /tmp/input.json <<EOF
{
  "anthropic_version": "bedrock-2023-05-31",
  "messages": [
    {
      "role": "user",
      "content": "Say hello in a haiku"
    }
  ],
  "max_tokens": 100
}
EOF

echo -e "${CYAN}Testing Claude 3.5 Sonnet V1...${NC}"
if aws bedrock-runtime invoke-model \
  --model-id anthropic.claude-3-5-sonnet-20240620-v1:0 \
  --region us-west-2 \
  --body fileb:///tmp/input.json \
  --content-type application/json \
  --accept application/json \
  --no-cli-pager \
  /tmp/outfile_v1.json 2>/dev/null; then
  
  echo -e "${GREEN}✅ V1 Model invocation successful!${NC}"
  echo ""
  validate_model_response "/tmp/outfile_v1.json" "Claude 3.5 Sonnet V1"
else
  echo -e "${RED}❌ V1 Model invocation failed${NC}"
fi

echo ""
echo -e "${CYAN}Testing Claude 3.5 Sonnet V2...${NC}"
if [[ "$v2_available" == "true" ]]; then
  if aws bedrock-runtime invoke-model \
    --model-id anthropic.claude-3-5-sonnet-20241022-v2:0 \
    --region us-west-2 \
    --body fileb:///tmp/input.json \
    --content-type application/json \
    --accept application/json \
    --no-cli-pager \
    /tmp/outfile_v2.json 2>/dev/null; then
    
    echo -e "${GREEN}✅ V2 Model invocation successful!${NC}"
    echo ""
    validate_model_response "/tmp/outfile_v2.json" "Claude 3.5 Sonnet V2"
  else
    echo -e "${RED}❌ V2 Model invocation failed${NC}"
  fi
else
  echo -e "${YELLOW}⚠️  Skipping V2 test - model not fully available${NC}"
fi

echo ""
echo -e "${BLUE}📈 Checking provisioned throughput (should be empty for on-demand)...${NC}"
aws bedrock list-provisioned-model-throughputs \
  --region us-west-2 \
  --query "provisionedModelThroughputs[?starts_with(modelId, 'anthropic.claude')].[modelId, provisionedModelName, status]" \
  --output table --no-cli-pager

echo ""
echo -e "${GREEN}✅ Enhanced verification complete!${NC}"
echo ""
echo -e "${CYAN}📋 ENHANCED SUMMARY:${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
if [[ "$v2_available" == "true" ]]; then
  echo -e "${GREEN}✅ Claude 3.5 Sonnet V2: AVAILABLE and READY${NC}"
else
  echo -e "${YELLOW}⚠️  Claude 3.5 Sonnet V2: NOT FULLY AVAILABLE${NC}"
fi
echo "- Check the model availability table above for detailed status"
echo "- Models with AUTHORIZED + AVAILABLE should work"
echo "- V1 model test result shown above with validation"
echo "- V2 model test result shown above with validation"
echo "- Service quotas displayed (if accessible)"
echo "- Response validation performed for all successful tests"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

echo ""
echo -e "${CYAN}📋 QUOTA TROUBLESHOOTING SUMMARY:${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${YELLOW}If you're having trouble retrieving quota information, try these steps:${NC}"
echo ""
echo "1. Check your IAM permissions - you need these permissions:"
echo "   - servicequotas:ListServiceQuotas"
echo "   - servicequotas:GetServiceQuota"
echo "   - servicequotas:ListAWSDefaultServiceQuotas"
echo ""
echo "2. Add this policy to your IAM user (textract-api-user):"
echo '{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "servicequotas:ListServiceQuotas",
        "servicequotas:GetServiceQuota",
        "servicequotas:ListAWSDefaultServiceQuotas"
      ],
      "Resource": "*"
    }
  ]
}'
echo ""
echo "3. Alternatively, check your quotas directly in the AWS Console:"
echo "   - Go to Service Quotas in the AWS Console"
echo "   - Search for 'Amazon Bedrock'"
echo "   - View your applied quotas there"
echo ""
echo "4. You can also check your quotas using the AWS CLI with these commands:"
echo "   aws service-quotas list-service-quotas --service-code bedrock --region us-west-2 --output json > bedrock_quotas.json"
echo "   aws service-quotas list-aws-default-service-quotas --service-code bedrock --region us-west-2 --output json > bedrock_default_quotas.json"
echo "   Then examine the JSON files for quota information"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Cleanup
rm -f /tmp/input.json /tmp/outfile_v1.json /tmp/outfile_v2.json "$quotas_file" "$default_quotas_file"
