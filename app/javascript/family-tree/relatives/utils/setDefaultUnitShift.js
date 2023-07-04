import { min, prop } from 'family-tree/relatives/utils/methods';
import { arrangeParentsIn } from 'family-tree/relatives/utils/arrangeParentsIn';
import { arrangeInOrder, correctUnitsShift } from 'family-tree/relatives/utils/units';

export const setDefaultUnitShift = (family) => {
    const units = [family.parents, family.children];
    units.forEach(arrangeInOrder);
    arrangeParentsIn(family);
    const start = min(units.flat().map(prop('pos')));
    if (start !== 0)
        units.forEach(items => correctUnitsShift(items, start * -1));
};
//# sourceMappingURL=setDefaultUnitShift.js.map
