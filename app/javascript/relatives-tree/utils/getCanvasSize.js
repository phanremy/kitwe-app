import { max } from './index';
import { bottomOf, rightOf } from 'relatives-tree/utils/family';

export const getCanvasSize = (families) => ({
    width: max(families.map(rightOf)),
    height: max(families.map(bottomOf)),
});
//# sourceMappingURL=getCanvasSize.js.map
