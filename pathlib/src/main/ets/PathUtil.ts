export namespace PathUtil {
  const SEP = "/";


  export function join(...paths: string[]): string {
    return paths.join(SEP);
  }

  export function getName(fullPath: string): string {
    const index = fullPath.lastIndexOf(SEP);
    const name = fullPath.substring(index + 1);
    return name;
  }

  export function getParent(fullPath: string): string {
    const index = fullPath.lastIndexOf(SEP);
    const parent = fullPath.substring(0, index);
    return parent;
  }
}