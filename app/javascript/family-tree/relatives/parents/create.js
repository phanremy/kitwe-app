import { byGender, prop } from 'family-tree/relatives/utils/methods';
import { arrangeInOrder, newUnit } from 'family-tree/relatives/utils/units';
import { newFamily } from 'family-tree/relatives/utils/family';

const getParentUnits = (store, unit) => (unit.nodes.reduce((units, child) => {
    const parents = store
        .getNodes(child.parents.map(prop('id')))
        .sort(byGender(store.root.gender));
    if (parents.length)
        units.push(newUnit(unit.fid, parents));
    return units;
}, []));
const setDefaultUnitShift = (family) => {
    arrangeInOrder(family.children);
    arrangeInOrder(family.parents);
};
export const createFamilyFunc = (store) => {
    return (childIDs) => {
        const family = newFamily(store.getNextId(), "parent");
        const childUnit = newUnit(family.id, store.getNodes(childIDs), true);
        family.children = [childUnit];
        family.parents = getParentUnits(store, childUnit);
        setDefaultUnitShift(family);
        return family;
    };
};
//# sourceMappingURL=create.js.map
