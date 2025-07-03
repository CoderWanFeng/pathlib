import { _info } from "../../utils/LogUtil";
import { ConsoleViewController } from "./ConsoleViewController";


@Component
export struct ConsoleView {
  @State log: string = "";
  controller?: ConsoleViewController
  scroller: Scroller = new Scroller;

  aboutToAppear() {
    if (this.controller) {
      this.controller.appendLog = (log: string) => {
        this.log += "\n";
        this.log += log;
        this.scroller.scrollEdge(Edge.Bottom);
      }
    }
  }

  build() {
    Column() {
      Scroll(this.scroller) {
        Text(this.log)
          .width("100%")
      }.align(Alignment.Top)
      .height("100%");
    }
  }
}