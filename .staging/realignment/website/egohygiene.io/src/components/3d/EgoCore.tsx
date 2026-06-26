import React, { useRef } from 'react';
import { useFrame } from '@react-three/fiber';
import { animated, SpringValue, useSpring } from "@react-spring/three";
import type { Mesh } from 'three';

export default function EgoCore(): React.ReactElement {
  const mesh = useRef<Mesh>(null);
  const { scale } = useSpring({
    from: { scale: 1 },
    to: { scale: 1.1 },
    loop: { reverse: true },
    config: { duration: 2000 }
  }) as { scale: SpringValue<number> };

  useFrame(() => {
    if (mesh.current) mesh.current.rotation.y += 0.005;
  });

  return (
    <animated.mesh ref={mesh} scale={scale}>
      <sphereGeometry args={[1, 32, 32]} />
      <meshStandardMaterial emissive="#ff66ff" color="#ffffff" emissiveIntensity={1} />
    </animated.mesh>
  );
}
