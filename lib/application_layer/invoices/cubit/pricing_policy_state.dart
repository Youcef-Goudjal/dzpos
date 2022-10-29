part of 'pricing_policy_cubit.dart';

class PricingPolicyState extends Equatable {
  const PricingPolicyState({
    this.policy = PricingPolicy.fixed,
    this.status = Status.initial,
    this.method = PricingMethods.increaseCurrentSellingPrice,
    this.products = const [],
    this.modificationValue = 0,
    this.usePercentage = false,
    this.msg,
  });

  final Status status;
  final PricingPolicy policy;
  final PricingMethods method;
  final List<FullProduct> products;
  final double modificationValue;
  final bool usePercentage;
  final String? msg;

  @override
  List<Object> get props => [
        status,
        policy,
        method,
        products,
        usePercentage,
        modificationValue,
      ];

  PricingPolicyState copyWith({
    Status? status,
    PricingPolicy? policy,
    PricingMethods? method,
    double? modificationValue,
    bool? usePercentage,
    List<FullProduct>? products,
    String? msg,
  }) =>
      PricingPolicyState(
        status: status ?? Status.initial,
        policy: policy ?? this.policy,
        method: method ?? this.method,
        products: products ?? this.products,
        usePercentage: usePercentage ?? this.usePercentage,
        modificationValue: modificationValue ?? this.modificationValue,
        msg: msg,
      );
}
