import { createChildUnitsFunc } from 'family-tree/relatives/utils/createChildUnitsFunc';
import { createFamilyFunc } from 'family-tree/relatives/children/create';
import { getSpouseNodesFunc } from 'family-tree/relatives/utils/getSpouseNodesFunc';
import { setDefaultUnitShift } from 'family-tree/relatives/utils/setDefaultUnitShift';
import { prop, withRelType } from 'family-tree/relatives/utils/methods';
import { newFamily } from 'family-tree/relatives/utils/family';
import { unitsToNodes } from 'family-tree/relatives/utils/units';
import { NODES_IN_COUPLE } from 'family-tree/relatives/constants';
import { correctOverlaps } from 'family-tree/relatives/middle/correctOverlaps';

export const createFamilyWithoutParents = (store) => {
    const family = newFamily(store.getNextId(), "root", true);
    family.children = createChildUnitsFunc(store)(family.id, store.root);
    setDefaultUnitShift(family);
    return [family];
};
const getParentIDs = (root, type) => (root.parents.filter(withRelType(type)).map(prop('id')));
export const createDiffTypeFamilies = (store) => {
    const createFamily = createFamilyFunc(store);
    const bloodFamily = createFamily(getParentIDs(store.root, "blood"), "root", true);
    const adoptedFamily = createFamily(getParentIDs(store.root, "adopted"));
    correctOverlaps(bloodFamily, adoptedFamily);
    return [bloodFamily, adoptedFamily];
};
export const createBloodFamilies = (store) => {
    const createFamily = createFamilyFunc(store);
    const mainFamily = createFamily(store.root.parents.map(prop('id')), "root", true);
    const parents = unitsToNodes(mainFamily.parents);
    if (parents.length === NODES_IN_COUPLE) {
        const { left, right } = getSpouseNodesFunc(store)(parents);
        return [
            left.map(node => createFamily([node.id])),
            mainFamily,
            right.map(node => createFamily([node.id])),
        ].flat();
    }
    return [mainFamily];
};
//# sourceMappingURL=create.js.map
