import { createChildUnitsFunc } from 'relatives-tree/utils/createChildUnitsFunc';
import { createFamilyFunc } from 'relatives-tree/children/create';
import { getSpouseNodesFunc } from 'relatives-tree/utils/getSpouseNodesFunc';
import { setDefaultUnitShift } from 'relatives-tree/utils/setDefaultUnitShift';
import { prop, withRelType } from 'relatives-tree/utils';
import { newFamily } from 'relatives-tree/utils/family';
import { unitsToNodes } from 'relatives-tree/utils/units';
import { NODES_IN_COUPLE } from 'relatives-tree/constants';
import { correctOverlaps } from 'relatives-tree/middle/correctOverlaps';

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
