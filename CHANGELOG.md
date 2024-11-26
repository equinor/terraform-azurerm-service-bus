# Changelog

## [1.7.0](https://github.com/equinor/terraform-azurerm-service-bus/compare/v1.6.0...v1.7.0) (2024-11-26)


### Features

* create queues and topics ([#61](https://github.com/equinor/terraform-azurerm-service-bus/issues/61)) ([39aa8f5](https://github.com/equinor/terraform-azurerm-service-bus/commit/39aa8f5b44b3a0767b3d0cd5cd0b912bfdc9c9d9))

## [1.6.0](https://github.com/equinor/terraform-azurerm-service-bus/compare/v1.5.0...v1.6.0) (2024-11-11)


### Features

* output namespace name ([#68](https://github.com/equinor/terraform-azurerm-service-bus/issues/68)) ([3a47c33](https://github.com/equinor/terraform-azurerm-service-bus/commit/3a47c33fe0786d55c663daf2f5de385a896238b6))

## [1.5.0](https://github.com/equinor/terraform-azurerm-service-bus/compare/v1.4.2...v1.5.0) (2024-11-05)


### Features

* implicitly enable public network access ([#66](https://github.com/equinor/terraform-azurerm-service-bus/issues/66)) ([3c8a58d](https://github.com/equinor/terraform-azurerm-service-bus/commit/3c8a58d0557056654ea603886fcd8264f42c2a4d))

## [1.4.2](https://github.com/equinor/terraform-azurerm-service-bus/compare/v1.4.1...v1.4.2) (2024-10-30)


### Bug Fixes

* allow IP rules configuration for all SKUs ([#64](https://github.com/equinor/terraform-azurerm-service-bus/issues/64)) ([f14c266](https://github.com/equinor/terraform-azurerm-service-bus/commit/f14c266d7c119be4da233f7f084e7c68fd7c1976))

## [1.4.1](https://github.com/equinor/terraform-azurerm-service-bus/compare/v1.4.0...v1.4.1) (2024-10-02)


### Bug Fixes

* disable public network access by default ([#62](https://github.com/equinor/terraform-azurerm-service-bus/issues/62)) ([558e9da](https://github.com/equinor/terraform-azurerm-service-bus/commit/558e9daa973d8a5516182155bbe66f74185e9000))

## [1.4.0](https://github.com/equinor/terraform-azurerm-service-bus/compare/v1.3.0...v1.4.0) (2024-09-30)


### Features

* configure network rule set ([#50](https://github.com/equinor/terraform-azurerm-service-bus/issues/50)) ([a0f05ed](https://github.com/equinor/terraform-azurerm-service-bus/commit/a0f05eded68f1647cff78cadfdc4dc507aed056a))
* deny public network access by default ([#58](https://github.com/equinor/terraform-azurerm-service-bus/issues/58)) ([5c53ac8](https://github.com/equinor/terraform-azurerm-service-bus/commit/5c53ac8ed6942edf66d58b238839b166fe7b5999))
* disable local authentication by default ([#53](https://github.com/equinor/terraform-azurerm-service-bus/issues/53)) ([021714d](https://github.com/equinor/terraform-azurerm-service-bus/commit/021714d5a8c615d71e4f73917857e980df98b127))
* send only audit logs to Log Analytics by default ([#56](https://github.com/equinor/terraform-azurerm-service-bus/issues/56)) ([d38e3a1](https://github.com/equinor/terraform-azurerm-service-bus/commit/d38e3a10c807e66777b485c42cc6bbe054b8b691))

## [1.3.0](https://github.com/equinor/terraform-azurerm-service-bus/compare/v1.2.0...v1.3.0) (2024-03-21)


### Features

* add managed identity ([#43](https://github.com/equinor/terraform-azurerm-service-bus/issues/43)) ([17c04c4](https://github.com/equinor/terraform-azurerm-service-bus/commit/17c04c4fa03cab998bee1b684544ac3202a0464a))
* add outputs ([#42](https://github.com/equinor/terraform-azurerm-service-bus/issues/42)) ([cd6e60d](https://github.com/equinor/terraform-azurerm-service-bus/commit/cd6e60d3fd55629632cd64f3ebfa9e6481c02339))

## [1.2.0](https://github.com/equinor/terraform-azurerm-service-bus/compare/v1.1.2...v1.2.0) (2024-02-22)


### Features

* variable for diagnostic settng metric ([#38](https://github.com/equinor/terraform-azurerm-service-bus/issues/38)) ([a00ccd8](https://github.com/equinor/terraform-azurerm-service-bus/commit/a00ccd821b6c484f7fe044cb91d57aa090155331))

## [1.1.2](https://github.com/equinor/terraform-azurerm-service-bus/compare/v1.1.1...v1.1.2) (2024-02-15)


### Bug Fixes

* tags not assigned ([#33](https://github.com/equinor/terraform-azurerm-service-bus/issues/33)) ([b242f21](https://github.com/equinor/terraform-azurerm-service-bus/commit/b242f21389d4f78d61023e07c821caf4b55d34db))

## [1.1.1](https://github.com/equinor/terraform-azurerm-service-bus/compare/v1.1.0...v1.1.1) (2023-12-20)


### Bug Fixes

* remove diagnostic setting retention policies ([#30](https://github.com/equinor/terraform-azurerm-service-bus/issues/30)) ([393f80c](https://github.com/equinor/terraform-azurerm-service-bus/commit/393f80c1fc81acd15ea07bdf21299270b9f69135))

## [1.1.0](https://github.com/equinor/terraform-azurerm-service-bus/compare/v1.0.1...v1.1.0) (2023-07-26)


### Features

* create Service Bus namespace ([#3](https://github.com/equinor/terraform-azurerm-service-bus/issues/3)) ([7f9cb22](https://github.com/equinor/terraform-azurerm-service-bus/commit/7f9cb228747d327d7d63bf3949b40166d63e8f59))


### Bug Fixes

* don't specify Log Analytics destination type ([#6](https://github.com/equinor/terraform-azurerm-service-bus/issues/6)) ([4b4ae8e](https://github.com/equinor/terraform-azurerm-service-bus/commit/4b4ae8e2260e35b3e02d5eeaa3b9630b54ebf2ff))

## [1.0.1](https://github.com/equinor/terraform-azurerm-service-bus/compare/v1.0.0...v1.0.1) (2023-07-26)


### Bug Fixes

* don't specify Log Analytics destination type ([#6](https://github.com/equinor/terraform-azurerm-service-bus/issues/6)) ([4b4ae8e](https://github.com/equinor/terraform-azurerm-service-bus/commit/4b4ae8e2260e35b3e02d5eeaa3b9630b54ebf2ff))

## 0.1.0 (2023-06-05)


### Features

* create Service Bus namespace ([#3](https://github.com/equinor/terraform-azurerm-service-bus/issues/3)) ([7f9cb22](https://github.com/equinor/terraform-azurerm-service-bus/commit/7f9cb228747d327d7d63bf3949b40166d63e8f59))
