// Copyright (c) 2022 WSO2 LLC. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;

# This is a generated connector for [Shippit API v3.0.20201008](https://developer.shippit.com) OpenAPI specification.
# Shippit powers simpler delivery for e-commerce retailers of all shapes and sizes.
# It fulfil orders and track shipments anywhere you are, anytime you like. 
# It’s cloud-based multi-carrier shipping software for retailers that takes the guesswork out of shipping decisions.
@display {label: "Shippit", iconPath: "icon.png"}
public isolated client class Client {
    final http:Client clientEp;
    # Gets invoked to initialize the `connector`.
    # The connector initialization requires setting the API credentials. 
    # Create a [Shippit account](https://www.shippit.com) and obtain tokens by following [this guide](https://developer.shippit.com/#section/Authentication).
    #
    # + config - The configurations to be used when initializing the `connector` 
    # + serviceUrl - URL of the target service 
    # + return - An error if connector initialization failed 
    public isolated function init(ConnectionConfig config, string serviceUrl = "https://app.staging.shippit.com/api/3") returns error? {
        http:ClientConfiguration httpClientConfig = {auth: config.auth, httpVersion: config.httpVersion, timeout: config.timeout, forwarded: config.forwarded, poolConfig: config.poolConfig, compression: config.compression, circuitBreaker: config.circuitBreaker, retryConfig: config.retryConfig, validation: config.validation};
        do {
            if config.http1Settings is ClientHttp1Settings {
                ClientHttp1Settings settings = check config.http1Settings.ensureType(ClientHttp1Settings);
                httpClientConfig.http1Settings = {...settings};
            }
            if config.http2Settings is http:ClientHttp2Settings {
                httpClientConfig.http2Settings = check config.http2Settings.ensureType(http:ClientHttp2Settings);
            }
            if config.cache is http:CacheConfig {
                httpClientConfig.cache = check config.cache.ensureType(http:CacheConfig);
            }
            if config.responseLimits is http:ResponseLimitConfigs {
                httpClientConfig.responseLimits = check config.responseLimits.ensureType(http:ResponseLimitConfigs);
            }
            if config.secureSocket is http:ClientSecureSocket {
                httpClientConfig.secureSocket = check config.secureSocket.ensureType(http:ClientSecureSocket);
            }
            if config.proxy is http:ProxyConfig {
                httpClientConfig.proxy = check config.proxy.ensureType(http:ProxyConfig);
            }
        }
        http:Client httpEp = check new (serviceUrl, httpClientConfig);
        self.clientEp = httpEp;
        return;
    }
    # Create an Order
    #
    # + payload - Passes an Order object under the `order` field. 
    # + return - Successful order response 
    remote isolated function createOrder(OrderRequest payload) returns OrderResponse|error {
        string resourcePath = string `/orders`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        OrderResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Cancel an Order
    #
    # + trackingNumber - The tracking number of the Order. 
    # + return - Returns the Order with state = `cancelled` 
    remote isolated function cancelOrder(string trackingNumber) returns OrderDeleteResponse|error {
        string resourcePath = string `/orders/${getEncodedUri(trackingNumber)}`;
        OrderDeleteResponse response = check self.clientEp-> delete(resourcePath);
        return response;
    }
    # Get Label information for an Order
    #
    # + trackingNumber - The tracking number of the Order. 
    # + return - Returns an Order and related label information. 
    remote isolated function getOrderLabel(string trackingNumber) returns LabelResponse|error {
        string resourcePath = string `/orders/${getEncodedUri(trackingNumber)}/label`;
        LabelResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Track Order
    #
    # + trackingNumber - The tracking number of the Order 
    # + return - Returns tracking info related to the Order 
    remote isolated function trackOrder(string trackingNumber) returns TrackingResponse|error {
        string resourcePath = string `/orders/${getEncodedUri(trackingNumber)}/tracking`;
        TrackingResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Retrieve Quote
    #
    # + payload - Quote request 
    # + return - Successful quote response 
    remote isolated function getQuote(QuoteRequest payload) returns QuoteResponse|error {
        string resourcePath = string `/quotes`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        QuoteResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get Merchant settings
    #
    # + return - Returns an object representing your merchant account settings. 
    remote isolated function getMerchant() returns MerchantResponse|error {
        string resourcePath = string `/merchant`;
        MerchantResponse response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Update Merchant settings
    #
    # + payload - Merchant request 
    # + return - The updated merchant account. 
    remote isolated function updateMerchant(MerchantRequest payload) returns MerchantResponse|error {
        string resourcePath = string `/merchant`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        MerchantResponse response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # Webhook
    #
    # + payload - Updated status info about the Order sent by the webhook. 
    # + return - The response (success) the webhook expects from your application endpoint. 
    remote isolated function trackOrderHook(WebhookRequest payload) returns http:Response|error {
        string resourcePath = string `/webhook`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        http:Response response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Book Order
    #
    # + payload - An array of Order tracking numbers to book 
    # + return - Returns the status of the bookings at each courier. This API will validate that all of the requested orders are accurate and ready to be booked, if all of the orders sent in cannot be booked, the response will detail which orders cannot be found. If this response is received, none of the order numbers sent in will have been booked. If a manifest fails to be generated, the response will include an array of orders on each manifest which were not booked. 
    remote isolated function bookOrder(BookRequest payload) returns BookResponse|error {
        string resourcePath = string `/book`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        BookResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }
}
