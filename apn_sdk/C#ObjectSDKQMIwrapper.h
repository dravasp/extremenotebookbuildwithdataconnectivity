#ifndef APN_SDK_H
#define APN_SDK_H

#ifdef __cplusplus
extern "C" {
#endif

// QMI Core
int define_pdp_context(int id, const char* apn, const char* ipType);
int activate_pdp_context(int id);
int configure_qos(int id, int priority, int latency, int throughputUL, int throughputDL);
int activate_esim_profile(const char* eid);

// IMS / USSD / Stability
int enable_ims_registration(const char* apn);
int enable_ussd(const char* code);
int enable_bearer_stability(const char* mode);
int enable_qos_monitoring(const char* mode);
int enable_security_audit(const char* level);

// APN Parser
int parse_apn_xml(const char* filename);
int parse_apn_mobileconfig(const char* filename);

// Policy Engine
int enforce_root_of_trust(void);
int apply_masking_rules(const char* rulesFile);
int enforce_trusted_lpa(const char* lpaFile);

// Checksum Validator
int validate_signed_binary(const char* file, const char* expectedHash);
int validate_config_file(const char* file, const char* expectedHash);

// Carrier Adapter
int provision_carrier_profile(const char* carrierName, const char* apn);
int sync_with_carrier_server(const char* carrierName);

// Automation Layer
int provision_all_carriers(void);
int apply_multi_apn_bundle(const char* configDir);

#ifdef __cplusplus
}
#endif

#endif // APN_SDK_H
