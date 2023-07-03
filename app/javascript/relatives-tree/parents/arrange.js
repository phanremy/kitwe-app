import { SIZE } from 'relatives-tree/constants';
import { correctUnitsShift, getUnitX, nodeCount, sameAs } from 'relatives-tree/utils/units';
import { rightOf, unitNodesCount, widthOf } from 'relatives-tree/utils/family';
import { nextIndex } from 'relatives-tree/utils/methods';

const arrangeNextFamily = (family, nextFamily) => {
    const unit = family.children[0];
    const index = nextFamily.parents.findIndex(sameAs(unit));
    index === 0 && nextFamily.parents[index].pos === 0
        ? nextFamily.X = getUnitX(family, unit)
        : nextFamily.parents[index].pos = getUnitX(family, unit) - nextFamily.X;
    const nextIdx = nextIndex(index);
    if (nextFamily.parents[nextIdx]) {
        correctUnitsShift(nextFamily.parents.slice(nextIdx), rightOf(family) - getUnitX(nextFamily, nextFamily.parents[nextIdx]));
    }
};
export const arrangeFamiliesFunc = (store) => ((family) => {
    while (family.cid) {
        const nextFamily = store.getFamily(family.cid);
        const unit = family.children[0];
        if (!nextFamily.cid) {
            unit.pos = (widthOf(family) - nodeCount(unit) * SIZE) / 2;
        }
        else {
            if (family.parents.length === 2 && unitNodesCount(family.parents) > 2)
                unit.pos = Math.floor(family.parents[1].pos / 2);
            arrangeNextFamily(family, nextFamily);
        }
        family = nextFamily;
    }
});
//# sourceMappingURL=arrange.js.map
