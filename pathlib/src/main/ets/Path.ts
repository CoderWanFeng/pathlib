import fs from '@ohos.file.fs';
import { PathUtil } from './PathUtil';
import { Context } from '@kit.AbilityKit';

export class Path {
  fullPath: string
  private _name: string;
  private _parent: string;
  static context: Context;

  constructor(...paths: string[]) {
    this.fullPath = PathUtil.join(...paths);
  }

  static initClass(context) {
    this.context = context;
  }

  /**
   * data/storage/el2/base/haps/demo/cache
   * @returns
   */
  static cache(): Path {
    const cacheDir = this.context.cacheDir;
    const path = new Path(cacheDir);
    return path;
  }

  /**
   * data/storage/el2/base/haps/demo/files
   * @returns
   */
  static files(): Path {
    const cacheDir = this.context.filesDir;
    const path = new Path(cacheDir);
    return path;
  }

  /**
   * data/storage/el2/base/haps/demo/temp
   * @returns
   */
  static temp(): Path {
    const cacheDir = this.context.tempDir;
    const path = new Path(cacheDir);
    return path;
  }

  get name(): string {
    if (this._name === undefined) {
      this._name = PathUtil.getName(this.fullPath);
    }
    return this._name;
  }

  getParent(): string {
    if (this._parent === undefined) {
      this._parent = PathUtil.getParent(this.fullPath);
    }
    return this._parent;
  }


  join(name: string): Path {
    if (!name) {
      return this;
    }
    const fullPath = PathUtil.join(this.fullPath, name);
    const path = new Path(fullPath);
    return path;
  }


  /**
   *
   * @returns is file exist.
   */
  exists(): boolean {
    return fs.accessSync(this.fullPath);
  }

  unlink() {
    fs.unlinkSync(this.fullPath);
  }

  /**
   * create parent for fullpath
   */
  createParentDirSync(fullPath: string): void {
    let parentDir: string | null = PathUtil.getParent(fullPath);
    if (parentDir) {
      if (fs.accessSync(parentDir)) {
        return;
      } else {
        this.createParentDirSync(parentDir);
        fs.mkdirSync(parentDir);
      }
    } else {
      //no parent
      fs.mkdirSync(fullPath);
    }
  }

  /** FileOperate **/
  touch(): boolean {
    if (this.exists()) {
      return false;
    }
    this.createParentDirSync(this.fullPath)
    let file = fs.openSync(this.fullPath, fs.OpenMode.CREATE);
    fs.closeSync(file);
    return true;
  }


  subPaths(): Path[] {
    return this.subFullPaths().map(_fullPath => new Path(_fullPath));
  }

  subFullPaths(): string [] {
    if (fs.accessSync(this.fullPath)) {
      let list = fs.listFileSync(this.fullPath);
      let itemPaths = list.map((subName, index) => {
        let itemPath = PathUtil.join(this.fullPath, subName);
        return itemPath;
      });
      return itemPaths;
    } else {
      return [];
    }
  }

  isFile(): boolean {
    return fs.statSync(this.fullPath).isFile();
  }

  isDir(): boolean {
    return fs.statSync(this.fullPath).isDirectory();
  }

  rmdir() {
    if (!this.exists()) {
      return;
    }
    if (this.isDir()) {
      let subItems = this.subPaths();
      for (const item of subItems) {
        if (item.isDir()) {
          this.rmdir();
        } else {
          this.unlink();
        }
      }
      // delete empty dir
      fs.rmdir(this.fullPath);
    } else {
      this.unlink();
    }
  }


  /** DirOperate **/

}