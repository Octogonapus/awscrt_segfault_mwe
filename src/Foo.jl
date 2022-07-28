module Foo

using AWSCRT
using AWSCRT.LibAWSCRT

function start()
    if ENV["MQTT_ENABLED"] == "true"
        mqtt_endpoint = ENV["MQTT_ENDPOINT"]
        options = create_client_with_mtls_from_path(
            ENV["MQTT_CERT_PATH"],
            ENV["MQTT_PRIVATE_KEY_PATH"];
            ca_filepath=ENV["MQTT_CA_PATH"]
        )
        mqtt_client = MQTTClient(ClientTLSContext(options))
        mqtt_connection = MQTTConnection(mqtt_client)
        mqtt_client_id = "unknown-client-id"
        @info "MQTT connecting to endpoint $mqtt_endpoint"
        mqtt_connect_task = connect(mqtt_connection, mqtt_endpoint, 8883, mqtt_client_id; clean_session=false)
        mqtt_connect_task_result = fetch(mqtt_connect_task)
        @info "MQTT connect finished" mqtt_connect_task_result
    else
        mqtt_connection = nothing
    end
    return nothing
end

end
