#!/bin/bash

# Timestamp actual en nanosegundos
TS=$(date +%s%N)

# Enviar log OTLP HTTP
curl -v -X POST http://localhost:4318/v1/logs \
  -H "Content-Type: application/json" \
  -d '{
    "resourceLogs": [{
      "resource": {
        "attributes": [
          { "key": "service.name", "value": { "stringValue": "mi-app" } },
          { "key": "environment", "value": { "stringValue": "dev" } }
        ]
      },
      "scopeLogs": [{
        "scope": {
          "name": "demo-script",
          "version": "1.0.0"
        },
        "logRecords": [{
          "timeUnixNano": '"$TS"',
          "severityText": "INFO",
          "body": { "stringValue": "Log desde script con timestamp correcto y service.name" },
          "attributes": [
            { "key": "custom.key", "value": { "stringValue": "test" } }
          ]
        }]
      }]
    }]
  }'

echo -e "\n✅ Log enviado con timestamp actual: $TS"
