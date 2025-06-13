// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'dart:async';

// class PaywallPage extends StatefulWidget {
//   const PaywallPage({super.key});

//   static const String premiumUrl = 'https://flowfundsapp.co.ke/premium';

//   @override
//   State<PaywallPage> createState() => _PaywallPageState();
// }

// class _PaywallPageState extends State<PaywallPage>
//     with SingleTickerProviderStateMixin {
//   bool _isLoading = false;
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     );

//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Curves.easeIn,
//       ),
//     );

//     _animationController.forward();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   Future<void> _launchPremiumPage(BuildContext context) async {
//     setState(() {
//       _isLoading = true;
//     });

//     final scaffoldMessenger =
//         ScaffoldMessenger.of(context); // For use in async gap

//     try {
//       final Uri url = Uri.parse(PaywallPage.premiumUrl);
//       // It's generally recommended to use launchUrl directly without canLaunchUrl
//       // for http/https schemes as it performs its own checks.
//       if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
//         scaffoldMessenger.showSnackBar(
//           const SnackBar(
//             content: Text(
//                 'Could not open the premium page. Please try again later.'),
//             behavior: SnackBarBehavior.floating,
//             // Consider using theme error colors
//             // backgroundColor: Theme.of(context).colorScheme.error,
//           ),
//         );
//       }
//     } catch (e) {
//       scaffoldMessenger.showSnackBar(
//         SnackBar(
//           content: Text('Error: ${e.toString()}'),
//           behavior: SnackBarBehavior.floating,
//           // backgroundColor: Theme.of(context).colorScheme.error,
//         ),
//       );
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;
//     final textTheme = Theme.of(context).textTheme;
//     final brightness = Theme.of(context).brightness;

//     final primaryColor = colorScheme.primary; // Already theme-aware
//     final onPrimaryColor = colorScheme.onPrimary; // Already theme-aware

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Upgrade to Premium'),
//         centerTitle: true,
//         elevation: 0,
//         // AppBar background will be themed by default.
//         // If you need specific color: color: colorScheme.surface,
//       ),
//       body: FadeTransition(
//         opacity: _fadeAnimation,
//         child: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [
//                 colorScheme.surface, // Theme-aware surface color
//                 colorScheme
//                     .surfaceContainerLowest, // Theme-aware subtle gradient end
//               ],
//             ),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//             child: Column(
//               children: [
//                 const SizedBox(height: 16),
//                 Container(
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     boxShadow: [
//                       BoxShadow(
//                         color: primaryColor.withValues(
//                             alpha: 0.25), // Adjusted opacity
//                         blurRadius: 20,
//                         spreadRadius: 5,
//                       ),
//                     ],
//                   ),
//                   child: Icon(
//                     Icons.rocket_launch_rounded,
//                     size: 80,
//                     color: primaryColor,
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 Text(
//                   "Unlock Your Startup's Full Potential",
//                   textAlign: TextAlign.center,
//                   style: textTheme.headlineSmall?.copyWith(
//                     fontWeight: FontWeight.bold,
//                     color: colorScheme.onSurface,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
//                   decoration: BoxDecoration(
//                     color: colorScheme
//                         .surfaceContainerHigh, // Theme-aware container color
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         color: colorScheme.shadow
//                             .withValues(alpha: 0.1), // Theme-aware shadow
//                         blurRadius: 10,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Text(
//                     'Investors can message you even on the free plan — and you can reply. '
//                     'But with Premium, you take the lead.',
//                     textAlign: TextAlign.center,
//                     style: textTheme.bodyLarge?.copyWith(
//                       color: colorScheme.onSurfaceVariant,
//                       height: 1.5,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 32),
//                 _buildFeaturesList(context, colorScheme, textTheme, brightness),
//                 const SizedBox(height: 30),
//                 Text(
//                   "To upgrade, you'll be redirected to our secure website.",
//                   textAlign: TextAlign.center,
//                   style: textTheme.bodySmall?.copyWith(
//                     color: colorScheme.onSurfaceVariant,
//                   ),
//                 ),
//                 const Spacer(),
//                 ElevatedButton(
//                   onPressed:
//                       _isLoading ? null : () => _launchPremiumPage(context),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: primaryColor,
//                     foregroundColor: onPrimaryColor,
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 32, vertical: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     elevation: 4,
//                     shadowColor: primaryColor.withValues(alpha: 0.4),
//                     minimumSize: const Size(double.infinity, 56),
//                   ),
//                   child: _isLoading
//                       ? SizedBox(
//                           width: 24,
//                           height: 24,
//                           child: CircularProgressIndicator(
//                             color: onPrimaryColor,
//                             strokeWidth: 2.5,
//                           ),
//                         )
//                       : Text(
//                           'Go to Premium Page',
//                           style: textTheme.titleMedium?.copyWith(
//                               fontWeight: FontWeight.bold,
//                               color: onPrimaryColor),
//                         ),
//                 ),
//                 const SizedBox(height: 16),
//                 TextButton(
//                   onPressed: () {
//                     if (Navigator.canPop(context)) {
//                       Navigator.pop(context);
//                     }
//                   },
//                   style: TextButton.styleFrom(
//                     foregroundColor: colorScheme.primary,
//                   ),
//                   child: Text(
//                     "Maybe later",
//                     style: textTheme.labelLarge,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//               ],
//             ),
//           ),
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
//       // "Apply to exclusive pitch events",
//       // "Profile insights & analytics",
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
//     // Define success colors based on brightness
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
//                 color: colorScheme.onSurface, // Text on the container's surface
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'dart:async'; // For Future

// Define your RevenueCat Public API Key here.
// IMPORTANT: Use your specific project's API key (e.g., 'appl_XXXX', 'goog_XXXX').
// Do NOT use a secret key.
const String revenueCatPublicApiKey = 'goog_AMlqhOlymiZFnJqFNadnepvscTj';

class PaywallPage extends StatefulWidget {
  const PaywallPage({super.key});

  @override
  State<PaywallPage> createState() => _PaywallPageState();
}

class _PaywallPageState extends State<PaywallPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  // late Animation<double> _fadeAnimation;

  Offerings? _offerings;
  bool _isLoadingProducts = true;
  bool _isPurchasing = false;
  String? _errorLoadingProducts;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
    //   CurvedAnimation(
    //     parent: _animationController,
    //     curve: Curves.easeIn,
    //   ),
    // );

    _animationController.forward();
    _initRevenueCatAndFetchProducts();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _initRevenueCatAndFetchProducts() async {
    try {
      await Purchases.setLogLevel(LogLevel.debug); // Good for development
      PurchasesConfiguration configuration;

      // Platform-specific configuration
      if (Theme.of(context).platform == TargetPlatform.iOS) {
        configuration = PurchasesConfiguration(revenueCatPublicApiKey);
      } else if (Theme.of(context).platform == TargetPlatform.android) {
        configuration = PurchasesConfiguration(revenueCatPublicApiKey);
      } else {
        // Handle other platforms if necessary, or throw an error
        throw UnsupportedError('Unsupported platform');
      }

      await Purchases.configure(configuration);
      await _fetchProducts();
    } catch (e) {
      _errorLoadingProducts =
          'Failed to initialize RevenueCat: ${e.toString()}';
      _showSnackBar(_errorLoadingProducts!);
      debugPrint('RevenueCat init error: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingProducts = false;
        });
      }
    }
  }

  Future<void> _fetchProducts() async {
    setState(() {
      _isLoadingProducts = true;
      _errorLoadingProducts = null;
    });

    try {
      _offerings = await Purchases.getOfferings();
      if (_offerings == null || _offerings!.current == null) {
        _errorLoadingProducts =
            'No offerings found. Please configure products in RevenueCat.';
      }
    } catch (e) {
      _errorLoadingProducts = 'Failed to load products: ${e.toString()}';
      _showSnackBar(_errorLoadingProducts!);
      debugPrint('Error fetching offerings: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingProducts = false;
        });
      }
    }
  }

  Future<void> _purchasePackage(Package package) async {
    setState(() {
      _isPurchasing = true;
    });

    try {
      await Purchases.purchasePackage(package);
      // Purchase successful.
      // You might want to navigate away or show a success message.
      if (mounted) {
        _showSnackBar('Purchase successful!');
        Navigator.pop(context, true); // Optionally pop and indicate success
      }
    } catch (e) {
      // final PurchasesError error = PurchasesErrorHelper.get == PurchasesError.purchaseCancelled ? PurchasesErrorHelper.get(e); // This is how you correctly use PurchasesErrorHelper
      // if (error.code != PurchasesErrorCode.purchaseCancelledError) {
      //   // Only show error if it's not a cancellation
      //   _showSnackBar('Purchase failed: ${error.message}');
      //   debugPrint('Purchase error: ${error.message}');
      // } else {
      //   debugPrint('Purchase cancelled by user');
      // }
      print("The error is: $e");
    } finally {
      if (mounted) {
        setState(() {
          _isPurchasing = false;
        });
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
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final brightness = Theme.of(context).brightness;

    final primaryColor = colorScheme.primary;
    final onPrimaryColor = colorScheme.onPrimary;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upgrade to Premium'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 16,
          children: [
            const SizedBox(height: 32),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withValues(alpha: 0.25),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Icon(
                Icons.rocket_launch_rounded,
                size: 80,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.shadow.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                'Investors can message you even on the free plan — and you can reply. '
                'But with Premium, you take the lead.',
                textAlign: TextAlign.center,
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
            ),
            _buildFeaturesList(context, colorScheme, textTheme, brightness),
            const SizedBox(height: 30),
            _buildProductSection(colorScheme, textTheme, onPrimaryColor),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              style: TextButton.styleFrom(
                foregroundColor: colorScheme.primary,
              ),
              child: Text(
                "Maybe later",
                style: textTheme.labelLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturesList(BuildContext context, ColorScheme colorScheme,
      TextTheme textTheme, Brightness brightness) {
    final features = [
      "Message investors first",
      "See who's viewed your profile",
      "Priority placement in discovery",
      "Early access to new features",
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: features
            .map((feature) =>
                _buildFeatureTile(feature, colorScheme, textTheme, brightness))
            .toList(),
      ),
    );
  }

  Widget _buildFeatureTile(String text, ColorScheme colorScheme,
      TextTheme textTheme, Brightness brightness) {
    final bool isLight = brightness == Brightness.light;
    final Color successColor =
        isLight ? Colors.green.shade700 : Colors.greenAccent.shade400;
    final Color successContainerColor = isLight
        ? Colors.green.shade50
        : Colors.green.shade900.withValues(alpha: 0.4);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: successContainerColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_circle_rounded,
              color: successColor,
              size: 22,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
                color: colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductSection(
      ColorScheme colorScheme, TextTheme textTheme, Color onPrimaryColor) {
    if (_isLoadingProducts) {
      return Center(
        child: Column(
          children: [
            CircularProgressIndicator(color: colorScheme.primary),
            const SizedBox(height: 8),
            Text('Loading plans...', style: textTheme.bodySmall),
          ],
        ),
      );
    } else if (_errorLoadingProducts != null) {
      return Column(
        children: [
          Icon(Icons.error_outline, color: colorScheme.error, size: 40),
          const SizedBox(height: 8),
          Text(
            _errorLoadingProducts!,
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(color: colorScheme.error),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _fetchProducts,
            icon: const Icon(Icons.refresh),
            label: const Text('Try Again'),
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
            ),
          ),
        ],
      );
    } else if (_offerings == null ||
        _offerings!.current == null ||
        _offerings!.current!.availablePackages.isEmpty) {
      return Column(
        children: [
          Icon(Icons.info_outline,
              color: colorScheme.onSurfaceVariant, size: 40),
          const SizedBox(height: 8),
          Text(
            'No premium plans available at the moment. Please check back later.',
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium
                ?.copyWith(color: colorScheme.onSurfaceVariant),
          ),
        ],
      );
    } else {
      final currentOffering = _offerings!.current!;
      return Flexible(
        // Use Flexible or Expanded if this is inside a Column
        child: ListView.builder(
          shrinkWrap: true, // Important for ListView inside Column
          physics:
              const NeverScrollableScrollPhysics(), // To prevent scrolling if in Column
          itemCount: currentOffering.availablePackages.length,
          itemBuilder: (context, index) {
            final package = currentOffering.availablePackages[index];
            return _buildProductCard(
              package,
              colorScheme,
              textTheme,
              onPrimaryColor,
            );
          },
        ),
      );
    }
  }

  Widget _buildProductCard(
    Package package,
    ColorScheme colorScheme,
    TextTheme textTheme,
    Color onPrimaryColor, // This will be the text color of the button
  ) {
    return Padding(
      // Added Padding to give some space around the button
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: FilledButton(
        onPressed: _isPurchasing ? null : () => _purchasePackage(package),
        child: _isPurchasing
            ? CircularProgressIndicator(
                color: onPrimaryColor, // Color of the progress indicator
                strokeWidth: 2.5,
              )
            : Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // Aligns children to ends
                children: [
                  Text(
                    "Upgrade Now",
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: onPrimaryColor,
                    ),
                  ),
                  Text(
                    package.storeProduct.priceString, // The product price
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: onPrimaryColor,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
