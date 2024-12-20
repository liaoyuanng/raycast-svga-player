import { Detail, Clipboard } from "@raycast/api";
import { useState, useEffect } from "react";
import { playSvga } from "swift:../swift/svga-player";

export default function Main() {
  const [clipboardItem, setClipboardItem] = useState<Clipboard.ReadContent>();
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const readClipboard = async () => {
      try {
        const result = await Clipboard.read();
        setClipboardItem(result);
      } catch (error) {
        console.log("readClipboard error");
      } finally {
        setLoading(false);
      }
    };
    readClipboard();
  }, []);

  useEffect(() => {
    const handleClipboardContent = async () => {
      if (clipboardItem?.file) {
        const file = clipboardItem.file;
        await playSvga(file);
      } else if (clipboardItem?.text) {
        const text = clipboardItem.text;
        if (text.startsWith("http") && text.endsWith(".svga")) {
          await playSvga(text);
        }
      }
    };
    
    handleClipboardContent();
  }, [clipboardItem]);

  return <Detail markdown="Loading..." />;
}