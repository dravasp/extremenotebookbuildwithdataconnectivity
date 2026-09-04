#include "apn_sdk.h"
#include <stdio.h>

int main(void) {
    define_pdp_context(1, "jionet", "IPV4V6");
    activate_pdp_context(1);
    configure_qos(1, 1, 5, 256, 256);
    activate_esim_profile("EID-12345678901234567890123456789012");

    enable_ims_registration("ims");
    enable_ussd("*123#");
    enable_bearer_stability("all");
    enable_qos_monitoring("all");
    enable_security_audit("full");

    parse_apn_xml("configs/pdp_profiles.xml");
    parse_apn_mobileconfig("configs/apn.mobileconfig");

    enforce_root_of_trust();
    apply_masking_rules("masking_rules.json");
    enforce_trusted_lpa("trusted_lpa.conf");

    validate_signed_binary("libqmi.dll", "expectedSHA256");
    validate_config_file("pdp_profiles.json", "expectedSHA256");

    provision_carrier_profile("Jio", "jionet");
    sync_with_carrier_server("Airtel");

    provision_all_carriers();
    apply_multi_apn_bundle("configs/");

    printf("Test completed.\n");
    return 0
