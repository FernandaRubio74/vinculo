//ESTA POSIBLEMENTE MEJOR HAY QUE BORRARLA
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class VolunteersScreen extends StatelessWidget {
  const VolunteersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final volunteers = [
      {
        "name": "Sofía Ramírez",
        "interests": "Jardinería, Música",
        "photo":
            "https://lh3.googleusercontent.com/aida-public/AB6AXuBq2cAmjLnZze8D3RHOHhVi4kMAiRjHF-0sc1tnKnCyF1339WHBXg5foXOyun_OdYYi__jaMLVTRc01FBNeiCnFaYNSSR08vLqqgUiYbPBMZEQY-XjoGkgDnCP66ZLhdmzw1JKcMxDbUvRkx_dsLiD51PKnIKl9UTPgCwH86goOwPYbNfyYuEZ6LA8CYdwzqSZWDvEouv1gksm7bebUhS4poQEDhD5wRqeJa2c7vI0lT3f-634ac2_7Jhgj2ulwqPS3X4y7H93i0-Q",
      },
      {
        "name": "Carlos Mendoza",
        "interests": "Lectura, Historia",
        "photo":
            "https://lh3.googleusercontent.com/aida-public/AB6AXuCFVJgmLpJf33kvKbJvQCJP1Mj-DJydCvYwQMKPow9-RI4wo3CZwRgTXhTlBPx3YHoBZ6pPgwxE8ml-dJVpRtouoc4PQDYCeSaA1VjmEdgtfS9l1emoIObuck5EGOZ0tcVmUWD_opOByD5RfBAc2kklobMQOiDTnoKe2zf6sK9MrfXRxDRw4SVXfkX3JpZ_ysRDTr6yaa5Drv5aXVy8imPvd_corJPg9wpJTnQifH3H2fUoxYG9QrD1zXxyF75QWYnK6QApbk4HRAU",
      },
      {
        "name": "Ana López",
        "interests": "Cocina, Viajes",
        "photo":
            "https://lh3.googleusercontent.com/aida-public/AB6AXuCo9B0miBun21Nc2QUiDBs5d4sRt69JbX7nxsoN2fcJTB-eVHLg9mBJAan30XLaUDKO483xXhydC1PhM8y05gt_whwaSMksHq06Sqrwh8fFgYSmeoRxoWPeBO0WtTknXpsimTTeKDZriY6WS5kCXynb7MqtFNRSD2IerA5r3UqKL7kdaTp7Hza5JJo4GJW19je5IPqe4EuXE8N3X9rAhjydXFjJ0fgy-QwL9rs97_rcuVRemifZCMekGkXN0-LYZj6PZaEfGw4WyfA",
      },
      {
        "name": "Javier García",
        "interests": "Pintura, Naturaleza",
        "photo":
            "https://lh3.googleusercontent.com/aida-public/AB6AXuD8-R5MpaEUziItxKDBTCBIKdU5L6gsFshp6WhxUkhVa86BTkhHVwdqrTD69aWglWdVOrhVAoTTIDhMZalJEwE-x6GQ5eam35BYL8xHfc5e2PibPMiTMT_NYNXYWuGsiMV6y9xSxnNjJz_Ua8XS4pRp5pBPl7unbSIuub2izGRuRtJx4rCM-3BT-NpfvKJsYoOHjDnHSmk8t9aVgHHv50kQXR5WLBPRYLuuGoLJLyxmA1EphVGRB2miHAia6-Wr-zgG9E5ze3ghZEY",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          "Voluntarios Disponibles",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: volunteers.length,
        itemBuilder: (context, index) {
          final volunteer = volunteers[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Stack(
                    children: [
                      ClipOval(
                        child: Image.network(
                          volunteer["photo"]!,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 4,
                        right: 4,
                        child: Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          volunteer["name"]!,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Intereses: ${volunteer["interests"]}",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.go('/elderly/videocall?contact=${volunteer["name"]}');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF13a4ec),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(
                      Icons.videocam,
                    ),
                    label: const Text("Videollamada"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}