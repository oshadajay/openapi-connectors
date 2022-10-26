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

# This is a generated connector for [Storcove API v2](https://app.storecove.com/docs) OpenAPI Specification.
# Storecove API  provides the capability to do e-invoice management operations.
@display {label: "Storecove", iconPath: "icon.png"}
public isolated client class Client {
    final http:Client clientEp;
    # Gets invoked to initialize the `connector`.
    # The connector initialization requires setting the API credentials.
    # Create [Storcove account](https://www.storecove.com) and obtain tokens by following [this guide](https://app.storecove.com/docs#_getting_started).
    #
    # + config - The configurations to be used when initializing the `connector` 
    # + serviceUrl - URL of the target service 
    # + return - An error if connector initialization failed 
    public isolated function init(ConnectionConfig config, string serviceUrl = "https://api.storecove.com/api/v2") returns error? {
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
    # Discover Network Participant
    #
    # + payload - The participant to check 
    # + return - Success 
    remote isolated function discoveryReceives(DiscoverableParticipant payload) returns DiscoveredParticipant|error {
        string resourcePath = string `/discovery/receives`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        DiscoveredParticipant response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # *** NOTE: Experimental. Only to be used for sending Invoice Response documents. *** Submit a new document.
    #
    # + payload - Document to submit 
    # + return - Success 
    remote isolated function createDocumentSubmission(DocumentSubmission payload) returns DocumentSubmissionResult|error {
        string resourcePath = string `/document_submissions`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        DocumentSubmissionResult response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Submit a new invoice
    #
    # + payload - Invoice to submit 
    # + return - Success 
    remote isolated function createInvoiceSubmission(InvoiceSubmission payload) returns InvoiceSubmissionResult|error {
        string resourcePath = string `/invoice_submissions`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        InvoiceSubmissionResult response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Preflight an invoice recipient
    #
    # + payload - The invoice recipient to preflight 
    # + return - Success 
    remote isolated function preflightInvoiceRecipient(InvoiceRecipientPreflight payload) returns PreflightInvoiceRecipientResult|error {
        string resourcePath = string `/invoice_submissions/preflight`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        PreflightInvoiceRecipientResult response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get InvoiceSubmission Evidence
    #
    # + guid - InvoiceSubmission GUID 
    # + return - Success 
    remote isolated function showInvoiceSubmissionEvidence(string guid) returns InvoiceSubmissionEvidence|error {
        string resourcePath = string `/invoice_submissions/${getEncodedUri(guid)}/evidence`;
        InvoiceSubmissionEvidence response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a new LegalEntity
    #
    # + payload - LegalEntity to create 
    # + return - Success 
    remote isolated function createLegalEntity(LegalEntityCreate payload) returns LegalEntity|error {
        string resourcePath = string `/legal_entities`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        LegalEntity response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get LegalEntity
    #
    # + id - legal_entity id 
    # + return - Success 
    remote isolated function getLegalEntity(int id) returns LegalEntity|error {
        string resourcePath = string `/legal_entities/${getEncodedUri(id)}`;
        LegalEntity response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete LegalEntity
    #
    # + id - legal_entity id 
    # + return - Success 
    remote isolated function deleteLegalEntity(int id) returns http:Response|error {
        string resourcePath = string `/legal_entities/${getEncodedUri(id)}`;
        http:Response response = check self.clientEp-> delete(resourcePath);
        return response;
    }
    # Update LegalEntity
    #
    # + id - legal_entity id 
    # + payload - LegalEntity updates 
    # + return - Success 
    remote isolated function updateLegalEntity(int id, LegalEntityUpdate payload) returns LegalEntity|error {
        string resourcePath = string `/legal_entities/${getEncodedUri(id)}`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        LegalEntity response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # Create a new Administration
    #
    # + legalEntityId - The id of the LegalEntity for which to create the Administration 
    # + payload - Administration to create 
    # + return - Success 
    remote isolated function createAdministration(int legalEntityId, AdministrationCreate payload) returns Administration|error {
        string resourcePath = string `/legal_entities/${getEncodedUri(legalEntityId)}/administrations`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        Administration response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get Administration
    #
    # + legalEntityId - The id of the LegalEntity the Administration belongs to 
    # + id - The id of the Administration 
    # + return - Success 
    remote isolated function getAdministration(int legalEntityId, int id) returns Administration|error {
        string resourcePath = string `/legal_entities/${getEncodedUri(legalEntityId)}/administrations/${getEncodedUri(id)}`;
        Administration response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete Administration
    #
    # + legalEntityId - The id of the LegalEntity the Administration belongs to 
    # + id - The id of the Administration 
    # + return - Success 
    remote isolated function deleteAdministration(int legalEntityId, int id) returns http:Response|error {
        string resourcePath = string `/legal_entities/${getEncodedUri(legalEntityId)}/administrations/${getEncodedUri(id)}`;
        http:Response response = check self.clientEp-> delete(resourcePath);
        return response;
    }
    # Update Administration
    #
    # + legalEntityId - The id of the LegalEntity the Administration belongs to 
    # + id - The id of the Administration to be updated 
    # + payload - Administration to update 
    # + return - Success 
    remote isolated function updateAdministration(int legalEntityId, int id, AdministrationUpdate payload) returns Administration|error {
        string resourcePath = string `/legal_entities/${getEncodedUri(legalEntityId)}/administrations/${getEncodedUri(id)}`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        Administration response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # Create a new PeppolIdentifier
    #
    # + legalEntityId - The id of the LegalEntity for which to create the PeppolIdentifier 
    # + payload - PeppolIdentifier to create 
    # + return - Success 
    remote isolated function createPeppolIdentifier(int legalEntityId, PeppolIdentifierCreate payload) returns PeppolIdentifier|error {
        string resourcePath = string `/legal_entities/${getEncodedUri(legalEntityId)}/peppol_identifiers`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        PeppolIdentifier response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Delete PeppolIdentifier
    #
    # + legalEntityId - The id of the LegalEntity this PeppolIdentifier belongs to 
    # + superscheme - The superscheme of the identifier. Should always be "iso6523-actorid-upis". 
    # + scheme - PEPPOL identifier scheme id, e.g. "DE:VAT". For a full list see <<_peppol_participant_identifier_list>>. 
    # + identifier - PEPPOL identifier 
    # + return - Success 
    remote isolated function deletePeppolIdentifier(int legalEntityId, string superscheme, string scheme, string identifier) returns http:Response|error {
        string resourcePath = string `/legal_entities/${getEncodedUri(legalEntityId)}/peppol_identifiers/${getEncodedUri(superscheme)}/${getEncodedUri(scheme)}/${getEncodedUri(identifier)}`;
        http:Response response = check self.clientEp-> delete(resourcePath);
        return response;
    }
    # Get Purchase invoice data as JSON
    #
    # + guid - The guid of the purchase invoice, from the webhook. 
    # + pmv - The PaymentMeans version. The default (and deprecated) version 1.0 will give BankPaymentMean, DirectDebitPaymentMean, CardPaymentMean, NppPaymentMean, SeBankGiroPaymentMean, SePlusGiroPaymentMean, SgCardPaymentMean, SgGiroPaymentMean, SgPaynowPaymentMean. Version 2.0 deprecates BankPaymentMean (now CreditTransferPaymentMean), CardPaymentMean (now CreditCardPaymentMean), NppPaymentMean (now AunzNppPayidPaymentMean), SeBankGiroPaymentMean (now SeBankgiroPaymentMean  -- note the lower 'g' in 'bankgiro'). It also adds OnlinePaymentServicePaymentMean, StandingAgreementPaymentMean, AunzNppPaytoPaymentMean, AunzBpayPaymentMean, AunzPostbillpayPaymentMean, AunzUriPaymentMean. 
    # + return - Success 
    remote isolated function getInvoiceJson(string guid, string pmv = "1.0") returns PurchaseInvoice|error {
        string resourcePath = string `/purchase_invoices/${getEncodedUri(guid)}`;
        map<anydata> queryParam = {"pmv": pmv};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        PurchaseInvoice response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get Purchase invoice data as JSON with a Base64-encoded SI-1.2 UBL string
    #
    # + guid - purchase invoice guid 
    # + packaging - How to package the purchase invoice. Use "json" or "ubl"  
    # + return - Success 
    remote isolated function getInvoiceUbl(string guid, string packaging) returns PurchaseInvoiceUbl|error {
        string resourcePath = string `/purchase_invoices/${getEncodedUri(guid)}/${getEncodedUri(packaging)}`;
        PurchaseInvoiceUbl response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get Purchase invoice data as JSON with a Base64-encoded UBL string in the specified version
    #
    # + guid - purchase invoice guid 
    # + packaging - How to package the purchase invoice. Use "ubl" 
    # + packageVersion - The version of the ubl package. 
    # + return - Success 
    remote isolated function getInvoiceUblVersioned(string guid, string packaging, string packageVersion) returns PurchaseInvoiceUbl|error {
        string resourcePath = string `/purchase_invoices/${getEncodedUri(guid)}/${getEncodedUri(packaging)}/${getEncodedUri(packageVersion)}`;
        PurchaseInvoiceUbl response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get a WebhookInstance
    #
    # + return - Success 
    remote isolated function getWebhookInstances() returns WebhookInstance|error? {
        string resourcePath = string `/webhook_instances/`;
        WebhookInstance? response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete a WebhookInstance
    #
    # + guid - WebhookInstance guid 
    # + return - Success 
    remote isolated function deleteWebhookInstance(string guid) returns http:Response|error {
        string resourcePath = string `/webhook_instances/${getEncodedUri(guid)}`;
        http:Response response = check self.clientEp-> delete(resourcePath);
        return response;
    }
}
