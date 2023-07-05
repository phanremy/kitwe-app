import { max } from 'family-tree/relatives/utils/methods';
import { bottomOf, rightOf } from 'family-tree/relatives/utils/family';

export const getCanvasSize = (families) => ({
    width: max(families.map(rightOf)),
    height: max(families.map(bottomOf)),
});
//# sourceMappingURL=getCanvasSize.js.map
