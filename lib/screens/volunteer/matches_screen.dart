import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vinculo/utils/constants.dart';
import 'package:vinculo/config/providers/presentation/theme_provider.dart';
import 'package:vinculo/models/user_model.dart';
import 'package:vinculo/models/interest_model.dart';
import 'package:vinculo/config/providers/matching_provider.dart'; 

class MatchesScreen extends ConsumerWidget {
  const MatchesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final suggestionsState = ref.watch(matchSuggestionsProvider);
    final isDark = ref.watch(themeNotifierProvider).isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? AppConstants.backgroundDark : AppConstants.backgroundColor,
      appBar: AppBar(
        title: const Text('Descubrir Conexiones'),
        backgroundColor: isDark ? AppConstants.backgroundDark : AppConstants.backgroundColor,
        elevation: 0,
        foregroundColor: isDark ? Colors.white : Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.goNamed('volunteer-home'), 
        ),
      ),
      body: Center(

        child: suggestionsState.when(

          loading: () => const CircularProgressIndicator(color: AppConstants.primaryColor),
          
        
          error: (error, stack) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Error al cargar sugerencias: ${error.toString()}',
              textAlign: TextAlign.center,
            ),
          ),
          
          data: (suggestions) {
            if (suggestions.isEmpty) {
              return const Text(
                'No hay nuevas sugerencias por ahora.\n¡Vuelve más tarde!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey),
              );
            }
            
          
            return ListView.builder(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                final user = suggestions[index];
                return _MatchSuggestionCard(
                  user: user, 
                  isDark: isDark,
                  onConnect: () {
                
                    ref.read(matchSuggestionsProvider.notifier).sendConnectionRequest(user.id);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _MatchSuggestionCard extends StatelessWidget {
  const _MatchSuggestionCard({
    required this.user,
    required this.isDark,
    required this.onConnect,
  });

  final UserModel user;
  final bool isDark;
  final VoidCallback onConnect;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: AppConstants.largePadding),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias, 
      color: isDark ? AppConstants.backgroundDark.withOpacity(0.8) : Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Row(
              children: [
                Container(
                  width: 60, height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppConstants.secondaryColor.withOpacity(0.2),
                  ),
                  child: const Icon(Icons.person, size: 30, color: AppConstants.secondaryColor),
                ),
                const SizedBox(width: AppConstants.defaultPadding),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.fullName,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      Text(
                        'Prefiere: ${user.preferredGender ?? 'Cualquiera'}',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark ? AppConstants.hintColor : Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
            child: Text(
              user.bio ?? "Sin biografía disponible.",
              style: TextStyle(
                fontSize: 15,
                color: isDark ? AppConstants.hintColor : AppConstants.textColor,
                fontFamily: 'Public Sans',
                height: 1.4,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: AppConstants.defaultPadding),


          if (user.interests.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: user.interests.take(5).map((interest) { 
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppConstants.secondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(interest.icon, size: 16, color: AppConstants.secondaryColor),
                        const SizedBox(width: 6),
                        Text(
                          interest.name,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppConstants.secondaryColor,
                            fontFamily: 'Public Sans',
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          
          Padding(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onConnect,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstants.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                icon: const Icon(Icons.favorite, size: 20),
                label: const Text(
                  'Conectar',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Public Sans',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}