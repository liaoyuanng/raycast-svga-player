import React, { useRef, useEffect } from 'react'
import { Parser, Player } from 'svga'

const Home: React.FC = () => {
  const canvas = useRef<HTMLCanvasElement>(null)

  useEffect(() => {
    async function playSvga (): Promise<void> {
      const canvasElement = canvas.current
      if (canvasElement !== null) {
        const parser = new Parser()
        const svga = await parser.load('https://ovo-oss.duowan.com/upload/1625559566457.svga')
        const player = new Player(canvasElement)
        await player.mount(svga)
        player.start()
      }
    }
    playSvga().catch(error => console.error(error))
  })

  return (
    <canvas ref={canvas} />
  )
}

export default Home