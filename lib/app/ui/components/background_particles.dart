import 'package:flutter/material.dart';
import 'package:particle_field/particle_field.dart';
import 'package:personal_portifolio/app/core/common/constants/app_colors.dart';
import 'package:personal_portifolio/app/core/shared/session_memory.dart';
import 'package:rnd/rnd.dart';

class BackgroundParticles extends StatefulWidget {
  const BackgroundParticles({super.key});

  @override
  State<BackgroundParticles> createState() => _BackgroundParticlesState();
}

class _BackgroundParticlesState extends State<BackgroundParticles> {
  @override
  void initState() {
    if (mounted) setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ParticleField(
      blendMode: BlendMode.dstIn,
      origin: Alignment.topLeft,
      spriteSheet: SpriteSheet(
        image: MemoryImage(SessionMemory().particleIMG),
        scale: 0.7,
      ),
      onTick: (controller, elapsed, size) {
        List<Particle> particles = controller.particles;

        // Adiciona novas partículas com menor frequência
        if (elapsed.inMilliseconds % 100 == 0) {
          particles.add(
            Particle(
              color: AppColors.getRandomColor(),
              // set a starting location:
              x: rnd(size.width) * rnd.getSign(),
              vy: rnd(-1, 1),
            ),
          );
        }

        // Atualiza partículas e as remove quando saem da tela
        for (int i = particles.length - 1; i >= 0; i--) {
          Particle particle = particles[i];
          particle.update(
            vy: particle.vy + 0.01,
          ); // Menor aceleração (mais devagar)
          if (!size.contains(particle.toOffset())) particles.removeAt(i);
        }
      },
    );
  }
}
