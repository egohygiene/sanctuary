import React, { Suspense } from 'react';
import { Canvas } from '@react-three/fiber';
import { OrbitControls, Stars, Sparkles } from '@react-three/drei';
import EgoCore from './EgoCore.tsx';
import Planet from './Planet.tsx';
import HUDOverlay from './HUDOverlay.tsx';
import BackgroundAudio from './BackgroundAudio.tsx';
import type { Pillar } from '@egohygiene/models';

export default function LandingScene({ pillars }: { pillars: Pillar[] }): React.ReactElement {
  return (
    <div className="w-screen h-screen relative">
      <Canvas camera={{ position: [0, 0, 10] }}>
        <color attach="background" args={[ '#000000' ]} />
        <ambientLight intensity={0.5} />
        <pointLight position={[10, 10, 10]} intensity={1.2} />
        <Stars radius={100} depth={50} count={5000} factor={4} saturation={0} fade speed={1} />
        <Sparkles count={1000} scale={[100, 100, 100]} size={1} speed={0.5} color="white" />
        <Suspense fallback={null}>
          <EgoCore />
          {pillars.map((pillar, i) => (
            <Planet key={pillar.slug} pillar={pillar} index={i} total={pillars.length} />
          ))}
        </Suspense>
        <OrbitControls enablePan={true} enableZoom={true} />
      </Canvas>
      <HUDOverlay pillars={pillars} />
      {pillars.length > 0 && <BackgroundAudio />}
    </div>
  );
}
