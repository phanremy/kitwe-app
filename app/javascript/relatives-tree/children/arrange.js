import { correctUnitsShift, getUnitX, sameAs } from 'relatives-tree/utils/units';
import { rightOf } from 'relatives-tree/utils/family';
import { nextIndex, withId } from 'relatives-tree/utils/methods';
import { arrangeParentsIn } from 'relatives-tree/utils/arrangeParentsIn';

const arrangeNextFamily = (family, nextFamily) => {
    const unit = family.parents[0];
    const index = nextFamily.children.findIndex(sameAs(unit));
    index === 0
        ? nextFamily.X = getUnitX(family, unit) - nextFamily.children[index].pos
        : nextFamily.children[index].pos = getUnitX(family, unit) - nextFamily.X;
    const nextIdx = nextIndex(index);
    if (nextFamily.children[nextIdx]) {
        correctUnitsShift(nextFamily.children.slice(nextIdx), rightOf(family) - getUnitX(nextFamily, nextFamily.children[nextIdx]));
    }
};
const arrangeMiddleFamilies = (families, fid, startFrom) => {
    const start = nextIndex(families.findIndex(withId(fid)));
    const family = families[start];
    if (family) {
        const shift = startFrom - family.X;
        for (let i = start; i < families.length; i++)
            families[i].X += shift;
    }
};
export const arrangeFamiliesFunc = (store) => ((family) => {
    while (family.pid) {
        const nextFamily = store.getFamily(family.pid);
        arrangeNextFamily(family, nextFamily);
        arrangeParentsIn(nextFamily);
        if (!nextFamily.pid)
            arrangeMiddleFamilies(store.rootFamilies, nextFamily.id, rightOf(nextFamily));
        family = nextFamily;
    }
});
//# sourceMappingURL=arrange.js.map
