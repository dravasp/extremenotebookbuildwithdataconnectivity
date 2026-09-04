(EXPERT_MASTER_SCHEMATIC
  (VERSION 1.0)
  (TITLE "Extreme Performance Laptop - Aerospace Grade Schematic")

  ;; ===========================
  ;; Power Domains
  ;; ===========================
  (NET NET_PWR_CORE_1V2
    (SOURCE VRM_TI_TPS)
    (LOAD CPU_INTEL_I9_14900HX, GPU_NVIDIA_ADA5090M, NPU_INTEL_TOPS45)
    (DECOUPLING 100nF per pin, BulkCaps near GPU)
  )
  (NET NET_PWR_MEM_1V1
    (SOURCE VRM_TI_TPS)
    (LOAD MEMORY_DDR5X_MICRON)
    (DECOUPLING 100nF per pin)
  )
  (NET NET_PWR_HBM
    (SOURCE VRM_TI_TPS)
    (LOAD MEMORY_HBM3_STACK)
    (DECOUPLING 220nF per stack)
  )
  (NET NET_PWR_GPU_1V8
    (SOURCE MOSFET_INFINEON_OPTIMOS)
    (LOAD GPU_NVIDIA_ADA5090M)
  )
  (NET NET_PWR_BATT_11V1
    (SOURCE SOLID_STATE_BATTERY)
    (LOAD SYSTEM_DC_RAILS)
  )

  ;; ===========================
  ;; High-Speed Interfaces
  ;; ===========================
  (NET NET_PCIE_GPU
    (DIFF_PAIR TRUE IMPEDANCE 100Ω)
    (CONNECTION CPU_INTEL_I9_14900HX.PCIe_TX -> GPU_NVIDIA_ADA5090M.PCIe_RX)
    (CONNECTION GPU_NVIDIA_ADA5090M.PCIe_TX -> CPU_INTEL_I9_14900HX.PCIe_RX)
    (RULE Jitter <0.15UI EyeDiagram Compliant)
  )
  (NET NET_DDR5_BUS
    (WIDTH 64 bits)
    (CONNECTION CPU_INTEL_I9_14900HX.DDR5_CTRL -> MEMORY_DDR5X_MICRON.DATA[0..63])
    (RULE LengthMatch ±5 mils tCK=0.625ns tRCD=14ns tRP=14ns tRAS=32ns)
  )
  (NET NET_HBM_STACK
    (WIDTH 1024 bits)
    (CONNECTION GPU_NVIDIA_ADA5090M.HBM_CTRL -> MEMORY_HBM3_STACK.CTRL)
  )

  ;; ===========================
  ;; Security & Control
  ;; ===========================
  (NET NET_TPM_BUS
    (CONNECTION TPM_INFINEON.LPC_BUS -> CPU_INTEL_I9_14900HX.LPC_CTRL)
  )
  (NET NET_PLUTON_SPI
    (CONNECTION PLUTON_SEC_CHIP.SPI_BUS -> CPU_INTEL_I9_14900HX.SPI_CTRL)
  )
  (NET NET_SEC_CTRL
    (CONNECTION OPEN_TITAN_ROOT_OF_TRUST.CTRL -> SYSTEM_SECURITY_MANAGER)
  )

  ;; ===========================
  ;; Audio & Display
  ;; ===========================
  (NET NET_AUDIO_BUS
    (CONNECTION DAC_ESS_SABRE_ES9039PRO.I2S_IN -> DSP_DIRAC_LIVE.AUDIO_IN)
    (CONNECTION DSP_DIRAC_LIVE.AUDIO_OUT -> AMP_THX_AAA888.IN_L/IN_R)
  )
  (NET NET_AUDIO_OUT
    (CONNECTION AMP_THX_AAA888.OUT_HP -> AUDIO_JACK_3.5MM.L/R)
  )
  (NET NET_DISPLAY_BUS
    (CONNECTION CPU_INTEL_I9_14900HX.LVDS_TX -> DISPLAY_MICROLED_PANEL.LVDS_TX)
  )

  ;; ===========================
  ;; Connectivity
  ;; ===========================
  (NET NET_PCIE_WIFI
    (CONNECTION CPU_INTEL_I9_14900HX.PCIe_TX -> WIFI7_BT6_COMBO.PCIe_RX)
    (CONNECTION WIFI7_BT6_COMBO.PCIe_TX -> CPU_INTEL_I9_14900HX.PCIe_RX)
  )
  (NET NET_QSFP_TX
    (CONNECTION QSFP_DD_PORT_MOLEX.TX[0..7] -> NETWORK_BACKPLANE)
  )
  (NET NET_QSFP_RX
    (CONNECTION QSFP_DD_PORT_MOLEX.RX[0..7] -> NETWORK_BACKPLANE)
  )

  ;; ===========================
  ;; Mechanical Notes
  ;; ===========================
  (NOTE "Chassis: Aerospace Aluminum 7075-T6")
  (NOTE "Hinges: Titanium Ti-6Al-4V, 50,000 cycles")
  (NOTE "Thermal Inserts: Copper alloy")
  (NOTE "PCB Coating: Conformal, moisture/ESD shielding")
)
