import { byGender, relToNode, withId } from 'family-tree/relatives/utils/methods';
import { newUnit } from 'family-tree/relatives/utils/units';
import { newFamily } from 'family-tree/relatives/utils/family';
import { setDefaultUnitShift } from 'family-tree/relatives/utils/setDefaultUnitShift';
import { createChildUnitsFunc } from 'family-tree/relatives/utils/createChildUnitsFunc';
import { isNotDegradedMode } from 'family-tree/relatives/utils/treeTogglingOptions';

const hasSameRelation = (node) => ((rel) => !node || node.children.some(withId(rel.id)));
const getChildUnitsFunc = (store) => {
    const toNode = relToNode(store);
    const createChildUnits = createChildUnitsFunc(store);
    return (familyId, parents) => {
        const [first, second] = parents;
        return first.children
            .filter(hasSameRelation(second))
            .flatMap((rel) => createChildUnits(familyId, toNode(rel)));
    };
};
export const createFamilyFunc = (store) => {
    const getChildUnits = getChildUnitsFunc(store);
    return (parentIDs, type = "root", isMain = false) => {
        const family = newFamily(store.getNextId(), type, isMain);
        let parents = parentIDs.map(id => store.getNode(id))

        if (isNotDegradedMode())  {
          parents = parents.sort(byGender(store.root.gender));
        }

        // const parents = parentIDs
        //     .map(id => store.getNode(id))
        //     .sort(byGender(store.root.gender));
        family.parents = [newUnit(family.id, parents)];
        family.children = getChildUnits(family.id, parents);
        setDefaultUnitShift(family);
        return family;
    };
};
//# sourceMappingURL=create.js.map
