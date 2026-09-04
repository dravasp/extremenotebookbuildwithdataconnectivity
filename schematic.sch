(EXPERT_MASTER_SCHEMATIC
  (VERSION 1.1)
  (TITLE "Extreme Performance Laptop - Aerospace Grade Schematic (Re‑worked)")

  ;; ===========================
  ;; Power Domains
  ;; ===========================
  (NET NET_PWR_CORE_1V2
    (SOURCE VRM_TI_TPS)
    (LOAD CPU_INTEL_I9_14900HX, GPU_NVIDIA_ADA5090M, NPU_INTEL_TOPS45)
    (DECOUPLING "100nF per pin, bulk capacitors near GPU for stability")
  )
  (NET NET_PWR_MEM_1V1
    (SOURCE VRM_TI_TPS)
    (LOAD MEMORY_DDR5X_MICRON)
    (DECOUPLING "100nF per pin, distributed across DIMM sockets")
  )
  (NET NET_PWR_HBM
    (SOURCE VRM_TI_TPS)
    (LOAD MEMORY_HBM3_STACK)
    (DECOUPLING "220nF per stack, impedance-controlled placement")
  )
  (NET NET_PWR_GPU_1V8
    (SOURCE MOSFET_INFINEON_OPTIMOS)
    (LOAD GPU_NVIDIA_ADA5090M)
    (RULE "Low ESR capacitors placed within 2mm of pins")
  )
  (NET NET_PWR_BATT_11V1
    (SOURCE SOLID_STATE_BATTERY)
    (LOAD SYSTEM_DC_RAILS)
    (RULE "SMBus monitoring enabled, transient suppression applied")
  )

  ;; ===========================
  ;; High-Speed Interfaces
  ;; ===========================
  (NET NET_PCIE_GPU
    (DIFF_PAIR TRUE IMPEDANCE "100Ω differential")
    (CONNECTION CPU_INTEL_I9_14900HX.PCIe_TX -> GPU_NVIDIA_ADA5090M.PCIe_RX)
    (CONNECTION GPU_NVIDIA_ADA5090M.PCIe_TX -> CPU_INTEL_I9_14900HX.PCIe_RX)
    (RULE "Jitter <0.15UI, eye diagram compliant, pre-emphasis enabled")
  )
  (NET NET_DDR5_BUS
    (WIDTH "64 bits")
    (CONNECTION CPU_INTEL_I9_14900HX.DDR5_CTRL -> MEMORY_DDR5X_MICRON.DATA[0..63])
    (RULE "Length match ±5 mils, tCK=0.625ns, tRCD=14ns, tRP=14ns, tRAS=32ns")
  )
  (NET NET_HBM_STACK
    (WIDTH "1024 bits")
    (CONNECTION GPU_NVIDIA_ADA5090M.HBM_CTRL -> MEMORY_HBM3_STACK.CTRL)
    (RULE "Flux validated, impedance controlled routing")
  )

  ;; ===========================
  ;; Security & Control
  ;; ===========================
  (NET NET_TPM_BUS
    (CONNECTION TPM_INFINEON.LPC_BUS -> CPU_INTEL_I9_14900HX.LPC_CTRL)
    (RULE "FIPS140-3 compliance, secure enclave validation")
  )
  (NET NET_PLUTON_SPI
    (CONNECTION PLUTON_SEC_CHIP.SPI_BUS -> CPU_INTEL_I9_14900HX.SPI_CTRL)
    (RULE "Firmware attestation enabled, rollback protection")
  )
  (NET NET_SEC_CTRL
    (CONNECTION OPEN_TITAN_ROOT_OF_TRUST.CTRL -> SYSTEM_SECURITY_MANAGER)
    (RULE "Root of trust enforced, secure boot chain validated")
  )

  ;; ===========================
  ;; Audio & Display
  ;; ===========================
  (NET NET_AUDIO_BUS
    (CONNECTION DAC_ESS_SABRE_ES9039PRO.I2S_IN -> DSP_DIRAC_LIVE.AUDIO_IN)
    (CONNECTION DSP_DIRAC_LIVE.AUDIO_OUT -> AMP_THX_AAA888.IN_L/IN_R)
    (RULE "Shielded routing, THD+N ≤ -120dB, SNR ≥130dB")
  )
  (NET NET_AUDIO_OUT
    (CONNECTION AMP_THX_AAA888.OUT_HP -> AUDIO_JACK_3.5MM.L/R)
    (RULE "Low-noise path, gold-plated contacts")
  )
  (NET NET_DISPLAY_BUS
    (CONNECTION CPU_INTEL_I9_14900HX.LVDS_TX -> DISPLAY_MICROLED_PANEL.LVDS_TX)
    (RULE "Impedance controlled LVDS, EMI shielding applied")
  )

  ;; ===========================
  ;; Connectivity
  ;; ===========================
  (NET NET_PCIE_WIFI
    (CONNECTION CPU_INTEL_I9_14900HX.PCIe_TX -> WIFI7_BT6_COMBO.PCIe_RX)
    (CONNECTION WIFI7_BT6_COMBO.PCIe_TX -> CPU_INTEL_I9_14900HX.PCIe_RX)
    (RULE "WiFi7/BT6 PCIe tunneling validated")
  )
  (NET NET_QSFP_TX
    (CONNECTION QSFP_DD_PORT_MOLEX.TX[0..7] -> NETWORK_BACKPLANE)
    (RULE "400G lanes, skew ≤5ps, impedance 100Ω differential")
  )
  (NET NET_QSFP_RX
    (CONNECTION QSFP_DD_PORT_MOLEX.RX[0..7] -> NETWORK_BACKPLANE)
    (RULE "400G lanes, jitter <0.15UI, eye diagram compliant")
  )

  ;; ===========================
  ;; Mechanical Notes
  ;; ===========================
  (NOTE "Chassis: Aerospace Aluminum 7075-T6, anodized finish")
  (NOTE "Hinges: Titanium Ti-6Al-4V, validated for 50,000 cycles")
  (NOTE "Thermal Inserts: Copper alloy, optimized for conductivity")
  (NOTE "PCB Coating: Conformal, moisture/ESD shielding, aerospace-grade validation")
)
