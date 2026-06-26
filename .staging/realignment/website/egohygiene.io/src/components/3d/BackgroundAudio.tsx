import React from 'react';

export default function BackgroundAudio(): React.ReactElement {
  return (
    <audio src="/audio/ambient.mp3" autoPlay loop style={{ display: 'none' }} />
  );
}
