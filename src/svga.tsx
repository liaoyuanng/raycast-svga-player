import { Detail, Clipboard } from "@raycast/api";
import { useState, useEffect } from "react";
import SvgaPlayer from "./svga-player";

export default function Main() {
  const [clipboardItem, setClipboardItem] = useState<Clipboard.ReadContent>();
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const readClipboard = async () => {
      console.log("readClipboard");
      
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

    

    if (clipboardItem?.file) {
      const file = clipboardItem.file;
      console.log(file);
    } else if (clipboardItem?.text) {
      const text = clipboardItem.text;
      console.log(text);
    }
  }, [clipboardItem]);

  if (loading) {
    return <Detail markdown="Loading..." />;
  }
  return <SvgaPlayer resourceUrl={"file://Users/leo/Desktop/3C4CDF42-8C90-40E7-8918-A2D41B494E89.svga" ?? ""} />;
}