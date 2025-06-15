// import 'package:flutter/material.dart';
// import 'package:purchases_flutter/purchases_flutter.dart';
// import 'dart:async'; // For Future

// const String revenueCatPublicApiKey = 'goog_AMlqhOlymiZFnJqFNadnepvscTj';

// class PaywallPage extends StatefulWidget {
//   const PaywallPage({super.key});

//   @override
//   State<PaywallPage> createState() => _PaywallPageState();
// }

// class _PaywallPageState extends State<PaywallPage>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   // late Animation<double> _fadeAnimation;

//   Offerings? _offerings;
//   bool _isLoadingProducts = true;
//   bool _isPurchasing = false;
//   String? _errorLoadingProducts;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     );

//     // _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//     //   CurvedAnimation(
//     //     parent: _animationController,
//     //     curve: Curves.easeIn,
//     //   ),
//     // );

//     _animationController.forward();
//     _initRevenueCatAndFetchProducts();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   Future<void> _initRevenueCatAndFetchProducts() async {
//     try {
//       await Purchases.setLogLevel(LogLevel.debug); // Good for development
//       PurchasesConfiguration configuration;

//       // Platform-specific configuration
//       if (Theme.of(context).platform == TargetPlatform.iOS) {
//         configuration = PurchasesConfiguration(revenueCatPublicApiKey);
//       } else if (Theme.of(context).platform == TargetPlatform.android) {
//         configuration = PurchasesConfiguration(revenueCatPublicApiKey);
//       } else {
//         // Handle other platforms if necessary, or throw an error
//         throw UnsupportedError('Unsupported platform');
//       }

//       await Purchases.configure(configuration);
//       await _fetchProducts();
//     } catch (e) {
//       _errorLoadingProducts =
//           'Failed to initialize RevenueCat: ${e.toString()}';
//       _showSnackBar(_errorLoadingProducts!);
//       debugPrint('RevenueCat init error: $e');
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isLoadingProducts = false;
//         });
//       }
//     }
//   }

//   Future<void> _fetchProducts() async {
//     setState(() {
//       _isLoadingProducts = true;
//       _errorLoadingProducts = null;
//     });

//     try {
//       _offerings = await Purchases.getOfferings();
//       if (_offerings == null || _offerings!.current == null) {
//         _errorLoadingProducts =
//             'No offerings found. Please configure products in RevenueCat.';
//       }
//     } catch (e) {
//       _errorLoadingProducts = 'Failed to load products: ${e.toString()}';
//       _showSnackBar(_errorLoadingProducts!);
//       debugPrint('Error fetching offerings: $e');
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isLoadingProducts = false;
//         });
//       }
//     }
//   }

//   Future<void> _purchasePackage(Package package) async {
//     setState(() {
//       _isPurchasing = true;
//     });

//     try {
//       await Purchases.purchasePackage(package);
//       // Purchase successful.
//       // You might want to navigate away or show a success message.
//       if (mounted) {
//         _showSnackBar('Purchase successful!');
//         Navigator.pop(context, true); // Optionally pop and indicate success
//       }
//     } catch (e) {
//       // final PurchasesError error = PurchasesErrorHelper.get == PurchasesError.purchaseCancelled ? PurchasesErrorHelper.get(e); // This is how you correctly use PurchasesErrorHelper
//       // if (error.code != PurchasesErrorCode.purchaseCancelledError) {
//       //   // Only show error if it's not a cancellation
//       //   _showSnackBar('Purchase failed: ${error.message}');
//       //   debugPrint('Purchase error: ${error.message}');
//       // } else {
//       //   debugPrint('Purchase cancelled by user');
//       // }
//       print("The error is: $e");
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isPurchasing = false;
//         });
//       }
//     }
//   }

//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         behavior: SnackBarBehavior.floating,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;
//     final textTheme = Theme.of(context).textTheme;
//     final brightness = Theme.of(context).brightness;

//     final primaryColor = colorScheme.primary;
//     final onPrimaryColor = colorScheme.onPrimary;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Upgrade to Premium'),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           spacing: 16,
//           children: [
//             const SizedBox(height: 32),
//             Container(
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 boxShadow: [
//                   BoxShadow(
//                     color: primaryColor.withValues(alpha: 0.25),
//                     blurRadius: 20,
//                     spreadRadius: 5,
//                   ),
//                 ],
//               ),
//               child: Icon(
//                 Icons.rocket_launch_rounded,
//                 size: 80,
//                 color: primaryColor,
//               ),
//             ),
//             const SizedBox(height: 32),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
//               decoration: BoxDecoration(
//                 color: colorScheme.surfaceContainerHigh,
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: [
//                   BoxShadow(
//                     color: colorScheme.shadow.withValues(alpha: 0.1),
//                     blurRadius: 10,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Text(
//                 'Investors can message you even on the free plan — and you can reply. '
//                 'But with Premium, you take the lead.',
//                 textAlign: TextAlign.center,
//                 style: textTheme.bodyLarge?.copyWith(
//                   color: colorScheme.onSurfaceVariant,
//                   height: 1.5,
//                 ),
//               ),
//             ),
//             _buildFeaturesList(context, colorScheme, textTheme, brightness),
//             const SizedBox(height: 30),
//             _buildProductSection(colorScheme, textTheme, onPrimaryColor),
//             const SizedBox(height: 16),
//             TextButton(
//               onPressed: () {
//                 if (Navigator.canPop(context)) {
//                   Navigator.pop(context);
//                 }
//               },
//               style: TextButton.styleFrom(
//                 foregroundColor: colorScheme.primary,
//               ),
//               child: Text(
//                 "Maybe later",
//                 style: textTheme.labelLarge,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildFeaturesList(BuildContext context, ColorScheme colorScheme,
//       TextTheme textTheme, Brightness brightness) {
//     final features = [
//       "Message investors first",
//       "See who's viewed your profile",
//       "Priority placement in discovery",
//       "Early access to new features",
//     ];

//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: colorScheme.surfaceContainerHigh,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: colorScheme.shadow.withValues(alpha: 0.1),
//             blurRadius: 10,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         children: features
//             .map((feature) =>
//                 _buildFeatureTile(feature, colorScheme, textTheme, brightness))
//             .toList(),
//       ),
//     );
//   }

//   Widget _buildFeatureTile(String text, ColorScheme colorScheme,
//       TextTheme textTheme, Brightness brightness) {
//     final bool isLight = brightness == Brightness.light;
//     final Color successColor =
//         isLight ? Colors.green.shade700 : Colors.greenAccent.shade400;
//     final Color successContainerColor = isLight
//         ? Colors.green.shade50
//         : Colors.green.shade900.withValues(alpha: 0.4);

//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(2),
//             decoration: BoxDecoration(
//               color: successContainerColor,
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               Icons.check_circle_rounded,
//               color: successColor,
//               size: 22,
//             ),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Text(
//               text,
//               style: textTheme.bodyLarge?.copyWith(
//                 fontWeight: FontWeight.w500,
//                 color: colorScheme.onSurface,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildProductSection(
//       ColorScheme colorScheme, TextTheme textTheme, Color onPrimaryColor) {
//     if (_isLoadingProducts) {
//       return Center(
//         child: Column(
//           children: [
//             CircularProgressIndicator(color: colorScheme.primary),
//             const SizedBox(height: 8),
//             Text('Loading plans...', style: textTheme.bodySmall),
//           ],
//         ),
//       );
//     } else if (_errorLoadingProducts != null) {
//       return Column(
//         children: [
//           Icon(Icons.error_outline, color: colorScheme.error, size: 40),
//           const SizedBox(height: 8),
//           Text(
//             _errorLoadingProducts!,
//             textAlign: TextAlign.center,
//             style: textTheme.bodyMedium?.copyWith(color: colorScheme.error),
//           ),
//           const SizedBox(height: 16),
//           ElevatedButton.icon(
//             onPressed: _fetchProducts,
//             icon: const Icon(Icons.refresh),
//             label: const Text('Try Again'),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: colorScheme.primary,
//               foregroundColor: colorScheme.onPrimary,
//             ),
//           ),
//         ],
//       );
//     } else if (_offerings == null ||
//         _offerings!.current == null ||
//         _offerings!.current!.availablePackages.isEmpty) {
//       return Column(
//         children: [
//           Icon(Icons.info_outline,
//               color: colorScheme.onSurfaceVariant, size: 40),
//           const SizedBox(height: 8),
//           Text(
//             'No premium plans available at the moment. Please check back later.',
//             textAlign: TextAlign.center,
//             style: textTheme.bodyMedium
//                 ?.copyWith(color: colorScheme.onSurfaceVariant),
//           ),
//         ],
//       );
//     } else {
//       final currentOffering = _offerings!.current!;
//       return Flexible(
//         // Use Flexible or Expanded if this is inside a Column
//         child: ListView.builder(
//           shrinkWrap: true, // Important for ListView inside Column
//           physics:
//               const NeverScrollableScrollPhysics(), // To prevent scrolling if in Column
//           itemCount: currentOffering.availablePackages.length,
//           itemBuilder: (context, index) {
//             final package = currentOffering.availablePackages[index];
//             return _buildProductCard(
//               package,
//               colorScheme,
//               textTheme,
//               onPrimaryColor,
//             );
//           },
//         ),
//       );
//     }
//   }

//   Widget _buildProductCard(
//     Package package,
//     ColorScheme colorScheme,
//     TextTheme textTheme,
//     Color onPrimaryColor, // This will be the text color of the button
//   ) {
//     return Padding(
//       // Added Padding to give some space around the button
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: FilledButton(
//         onPressed: _isPurchasing ? null : () => _purchasePackage(package),
//         child: _isPurchasing
//             ? CircularProgressIndicator(
//                 color: onPrimaryColor, // Color of the progress indicator
//                 strokeWidth: 2.5,
//               )
//             : Row(
//                 mainAxisAlignment:
//                     MainAxisAlignment.spaceBetween, // Aligns children to ends
//                 children: [
//                   Text(
//                     "Upgrade Now",
//                     style: textTheme.titleMedium?.copyWith(
//                       fontWeight: FontWeight.bold,
//                       color: onPrimaryColor,
//                     ),
//                   ),
//                   Text(
//                     package.storeProduct.priceString, // The product price
//                     style: textTheme.titleMedium?.copyWith(
//                       fontWeight: FontWeight.bold,
//                       color: onPrimaryColor,
//                     ),
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const String revenueCatPublicApiKey = 'goog_AMlqhOlymiZFnJqFNadnepvscTj';

class PaywallPage extends StatefulWidget {
  const PaywallPage({super.key});

  @override
  State<PaywallPage> createState() => _PaywallPageState();
}

class _PaywallPageState extends State<PaywallPage> {
  Offerings? _offerings;
  bool _isLoading = true;
  bool _isPurchasing = false;
  String? _errorMessage;
  bool userIsPremium = false;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _syncRevenueCatUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      // Important: Set the RevenueCat user ID to match Firebase UID
      await Purchases.logIn(user.uid);

      // Now get fresh customer info
      final customerInfo = await Purchases.getCustomerInfo();
      final isPremium = customerInfo.entitlements.active.containsKey('premium');

      setState(() => userIsPremium = isPremium);

      if (isPremium && mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      debugPrint('Error syncing RevenueCat user: $e');
    }
  }

  Future<void> _initialize() async {
    try {
      await _configureRevenueCat();
      // await _checkPremiumStatus();
      await _syncRevenueCatUser();
      await _loadOfferings();
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load offerings: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  Future<void> _configureRevenueCat() async {
    await Purchases.setLogLevel(LogLevel.debug);
    await Purchases.configure(
      PurchasesConfiguration(revenueCatPublicApiKey)
        ..appUserID = FirebaseAuth.instance.currentUser?.uid,
    );
  }

  // Future<void> _checkPremiumStatus() async {
  //   try {
  //     final customerInfo = await Purchases.getCustomerInfo();
  //     final isPremium = customerInfo.entitlements.active.containsKey('premium');

  //     if (mounted) {
  //       setState(() => userIsPremium = isPremium);
  //     }

  //     if (isPremium && mounted) {
  //       Navigator.pop(context, true);
  //       return;
  //     }

  //     await _syncPremiumStatusWithFirebase(isPremium);
  //   } catch (e) {
  //     debugPrint('Error checking premium status: $e');
  //   }
  // }

  Future<void> _syncPremiumStatusWithFirebase(bool isPremium) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      await FirebaseFirestore.instance
          .collection('startups')
          .doc(user.uid)
          .update({'isPremium': isPremium});
    } catch (e) {
      debugPrint('Error syncing premium status: $e');
    }
  }

  Future<void> _loadOfferings() async {
    try {
      final offerings = await Purchases.getOfferings();
      if (offerings.current == null ||
          offerings.current!.availablePackages.isEmpty) {
        throw Exception('No available packages found');
      }

      setState(() {
        _offerings = offerings;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load products. Please try again later.';
        _isLoading = false;
      });
    }
  }

  Future<void> _purchasePackage(Package package) async {
    if (_isPurchasing) return;

    setState(() => _isPurchasing = true);

    try {
      final customerInfo = await Purchases.purchasePackage(package);
      final isPremium = customerInfo.entitlements.active.containsKey('premium');

      if (isPremium) {
        await _syncPremiumStatusWithFirebase(true);
        if (mounted) {
          Navigator.pop(context, true);
        }
      } else {
        _showSnackBar('Purchase completed but premium not activated');
      }
    } on PlatformException catch (e) {
      if (e.code != PurchasesErrorCode.purchaseCancelledError.toString()) {
        _showSnackBar('Purchase failed: ${e.message}');
      }
    } catch (e) {
      _showSnackBar('An error occurred: ${e.toString()}');
    } finally {
      if (mounted) {
        setState(() => _isPurchasing = false);
      }
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Premium Features'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: 16,
          ),
          child: Column(
            children: [
              _buildHeroSection(theme),
              const SizedBox(height: 32),
              _buildFeaturesSection(theme),
              const SizedBox(height: 32),
              _buildPricingSection(theme),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Continue with free version'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection(ThemeData theme) {
    return Column(
      children: [
        Icon(
          Icons.rocket_launch,
          size: 80,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(height: 16),
        Text(
          'Unlock Your Startup\'s Potential',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Get noticed by more investors and grow faster with premium features',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.8),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildFeaturesSection(ThemeData theme) {
    final features = [
      'Message investors first',
      'See who viewed your profile',
      'Priority placement in search',
      'Advanced analytics',
      'Early access to new features',
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: features
            .map((feature) => _buildFeatureItem(feature, theme))
            .toList(),
      ),
    );
  }

  Widget _buildFeatureItem(String text, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPricingSection(ThemeData theme) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Column(
        children: [
          Icon(Icons.error_outline, color: theme.colorScheme.error, size: 48),
          const SizedBox(height: 16),
          Text(
            _errorMessage!,
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _initialize,
            child: const Text('Retry'),
          ),
        ],
      );
    }

    if (_offerings?.current?.availablePackages.isEmpty ?? true) {
      return const Text('No subscription plans available');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: _offerings!.current!.availablePackages.map((package) {
        return _buildPlanCard(package, theme);
      }).toList(),
    );
  }

  Widget _buildPlanCard(Package package, ThemeData theme) {
    final isPopular = package.identifier.contains('monthly'); // Example logic

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border.all(
          color: isPopular ? theme.colorScheme.primary : Colors.transparent,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _purchasePackage(package),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isPopular)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'POPULAR',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              Text(
                package.storeProduct.title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                package.storeProduct.description,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    package.storeProduct.priceString,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (_isPurchasing)
                    const CircularProgressIndicator()
                  else
                    FilledButton(
                      onPressed: () => _purchasePackage(package),
                      child: const Text('Get Started'),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
