class DeliveryOption {
  final int shippingOptionID;
  final String optionName;
  final String description;
  final String additionalCost;
  final String deliveryTime;
  final int isDefault;

  DeliveryOption({
    required this.shippingOptionID,
    required this.optionName,
    required this.description,
    required this.additionalCost,
    required this.deliveryTime,
    required this.isDefault,
  });

  factory DeliveryOption.fromJson(Map<String, dynamic> json) {
    return DeliveryOption(
      shippingOptionID: json['ShippingOptionID'] ?? 0,
      optionName: json['OptionName'] ?? "",
      description: json['Description'] ?? "",
      additionalCost: json['AdditionalCost'] ?? "0",
      deliveryTime: json['DeliveryTime'] ?? "",
      isDefault: json['IsDefault'] ?? 0,
    );
  }
}
