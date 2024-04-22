#!/bin/bash

# Step 1: Define Variables
namespace="sre"
deployment_name="swype-app"
max_restarts=3

# Step 2: Start a Loop
while true; do
    # Step 3: Check Pod Restarts
    restarts=$(kubectl get pods -n $namespace --selector=app=$deployment_name -o jsonpath='{.items[*].status.containerStatuses[*].restartCount}')

    # Step 4: Display Restart Count
    echo "Current number of restarts: $restarts"

    # Step 5: Check Restart Limit
    if [[ $restarts -gt $max_restarts ]]; then
        # Step 6: Scale Down if Necessary
        echo "Number of restarts exceeds maximum. Scaling down deployment."
        kubectl scale deployment $deployment_name --replicas=0 -n $namespace
        break
    else
        # Step 7: Pause
        echo "Number of restarts is within limit. Pausing for 60 seconds."
        sleep 60
    fi
done

# Step 8: Repeat
echo "Script ended."