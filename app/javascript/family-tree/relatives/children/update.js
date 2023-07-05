import { SIZE } from 'family-tree/relatives/constants';
import { heightOf } from 'family-tree/relatives/utils/family';
import { getUnitX } from 'family-tree/relatives/utils/units';

export const updateFamilyFunc = (store) => ((family, parentUnit) => {
    const parentFamily = store.getFamily(parentUnit.fid);
    family.pid = parentFamily.id;
    family.Y = parentFamily.Y + heightOf(parentFamily) - SIZE;
    family.X = getUnitX(parentFamily, parentUnit);
});
//# sourceMappingURL=update.js.map
