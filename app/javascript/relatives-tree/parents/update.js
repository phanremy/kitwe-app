import { SIZE } from 'relatives-tree/constants';
import { getUnitX } from 'relatives-tree/utils/units';

export const updateFamilyFunc = (store) => ((family, childUnit) => {
    const childFamily = store.getFamily(childUnit.fid);
    family.cid = childFamily.id;
    family.Y = childFamily.Y - SIZE;
    family.X = getUnitX(childFamily, childUnit);
});
//# sourceMappingURL=update.js.map
