import { Path } from "pathlib/Index"
import { ConsoleView } from "../components/console_view/ConsoleView";
import { ConsoleViewController } from "../components/console_view/ConsoleViewController";
import { FileExplorerViewController } from "../components/file_explorer_view/FileExplorerViewController";
import { FileExplorerView } from "../components/file_explorer_view/FileExporerView";
import { consoleController, registerController, _info } from "../utils/LogUtil";

@Entry
@Component
struct Home {
  cacheDir = getContext().cacheDir;
  @State curDir: string = this.cacheDir;
  @State log: string = "";
  consoleViewController: ConsoleViewController = new ConsoleViewController();
  fileController: FileExplorerViewController = new FileExplorerViewController();
  customPath: string = "";

  aboutToAppear() {
    registerController(this.consoleViewController);
  }

  build() {
    Flex({ direction: FlexDirection.Column }) {
      Flex({ direction: FlexDirection.Row }) {
        //操作区
        Column() {
          Column() {
            Text("CacheDir:")
            Text(this.cacheDir).fontSize(12)
          }
          .width("100%")
          .alignItems(HorizontalAlign.Start)

          Column() {
            Text("CustomPath:")
            TextInput({ placeholder: "请输入自定义路径" })
              .onChange((value: string) => {
                this.customPath = value;
              });
          }.alignItems(HorizontalAlign.Start)
          .margin({ top: 3 })


          Button() {
            Text("创建")
          }
          .width(100)
          .height(30)
          .margin({ top: 3 })
          .backgroundColor(Color.Transparent)
          .border({ color: Color.Gray, width: 1, radius: 15 })
          .onClick(() => {
            if (!this.customPath) {
              _info('custom path 不能为空')
              return;
            }
            const path = new Path(this.cacheDir).join(this.customPath);
            path.touch();
            this.fileController.reload();
            _info("文件创建成功");
          })
        }
        .padding(10)
        .borderWidth(1)
        .borderColor(Color.Gray)
        .borderRadius(5)
        .height("100%")
        .width(300)

        //文件夹预览区域
        FileExplorerView({
          curDir: this.curDir,
          controller: this.fileController
        })
          .borderWidth(1)
          .height("100%")
          .flexGrow(1)
          .borderColor(Color.Gray)
          .borderRadius(5)
      }.height("80%")

      //显示区域
      Row() {
        ConsoleView({
          controller: this.consoleViewController
        })
      }
      .padding(5)
      .height("30%")
      .width("100%")
      .borderWidth(1)
      .borderColor(Color.Gray)
      .borderRadius(5)
    }.height("100%")
    .width("100%")
  }
}