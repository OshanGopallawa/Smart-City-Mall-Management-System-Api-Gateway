#!/bin/sh

# Replace placeholder hostnames with real Render URLs from env vars
# Strip https:// prefix since nginx upstream uses just the hostname

USER_HOST=$(echo "$USER_SERVICE_URL" | sed 's|https://||')
OPERATOR_HOST=$(echo "$OPERATOR_SERVICE_URL" | sed 's|https://||')
MALL_API_HOST=$(echo "$MALL_API_SERVICE_URL" | sed 's|https://||')
ANALYTICS_HOST=$(echo "$ANALYTICS_SERVICE_URL" | sed 's|https://||')

sed -i "s|USER_SERVICE_HOST|$USER_HOST|g"         /etc/nginx/nginx.conf
sed -i "s|OPERATOR_SERVICE_HOST|$OPERATOR_HOST|g" /etc/nginx/nginx.conf
sed -i "s|MALL_API_SERVICE_HOST|$MALL_API_HOST|g" /etc/nginx/nginx.conf
sed -i "s|ANALYTICS_SERVICE_HOST|$ANALYTICS_HOST|g" /etc/nginx/nginx.conf

echo "Gateway configured with:"
echo "  user-service    -> $USER_HOST"
echo "  operator-service-> $OPERATOR_HOST"
echo "  mall-api-service-> $MALL_API_HOST"
echo "  analytics-service-> $ANALYTICS_HOST"

exec "$@"
