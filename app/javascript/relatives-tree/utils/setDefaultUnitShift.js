import { min, prop } from 'relatives-tree/utils/methods';
import { arrangeParentsIn } from 'relatives-tree/utils/arrangeParentsIn';
import { arrangeInOrder, correctUnitsShift } from 'relatives-tree/utils/units';

export const setDefaultUnitShift = (family) => {
    const units = [family.parents, family.children];
    units.forEach(arrangeInOrder);
    arrangeParentsIn(family);
    const start = min(units.flat().map(prop('pos')));
    if (start !== 0)
        units.forEach(items => correctUnitsShift(items, start * -1));
};
//# sourceMappingURL=setDefaultUnitShift.js.map
