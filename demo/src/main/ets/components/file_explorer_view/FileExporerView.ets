import { _info } from "../../utils/LogUtil";
import { Path } from "pathlib"
import { FileExplorerViewController } from "./FileExplorerViewController";


@Component
export struct FileExplorerView {
  @Link curDir: string
  @State items: Path[] = [];
  controller?: FileExplorerViewController

  reload() {
    if (this.curDir) {
      const path = new Path(this.curDir);
      const subs = path.subFullPaths();
      this.items = subs.map(sub => new Path(sub));
    }
  }

  aboutToAppear() {
    this.reload();
    if (this.controller) {
      this.controller.reload = () => {
        this.reload()
      }
    }
  }

  build() {
    Flex() {
      ForEach(this.items, (item: Path) => {
        Row() {
          Text("")
          Text(item.name)
        }
        .margin(3)
        .border({ color: Color.Gray, width: 1, radius: 5 })
      }, (item: Path, index: number) => {
        return item.fullPath;
      })
    }
  }
}