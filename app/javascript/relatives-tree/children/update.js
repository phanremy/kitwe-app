import { SIZE } from 'relatives-tree/constants';
import { heightOf } from 'relatives-tree/utils/family';
import { getUnitX } from 'relatives-tree/utils/units';

export const updateFamilyFunc = (store) => ((family, parentUnit) => {
    const parentFamily = store.getFamily(parentUnit.fid);
    family.pid = parentFamily.id;
    family.Y = parentFamily.Y + heightOf(parentFamily) - SIZE;
    family.X = getUnitX(parentFamily, parentUnit);
});
//# sourceMappingURL=update.js.map
