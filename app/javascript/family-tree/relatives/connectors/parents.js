import { prop, withIds } from 'family-tree/relatives/utils/methods';
import { getUnitX, nodeCount } from 'family-tree/relatives/utils/units';
import { getParentsX, withType } from 'family-tree/relatives/utils/family';
import { HALF_SIZE, NODES_IN_COUPLE, SIZE } from 'family-tree/relatives/constants';

const getChildIDs = (unit) => (unit.nodes.map(prop('children')).flat().map(prop('id')));
const calcConnectors = (family) => ((connectors, unit) => {
    const pX = getParentsX(family, unit);
    const pY = family.Y + HALF_SIZE;
    const mY = family.Y + SIZE;
    if (nodeCount(unit) === NODES_IN_COUPLE)
        connectors.push([pX - HALF_SIZE, pY, pX + HALF_SIZE, pY]);
    connectors.push([pX, pY, pX, mY]);
    const child = family.children[0];
    const cX = (getUnitX(family, child) +
        (child.nodes.findIndex(withIds(getChildIDs(unit))) * SIZE) + HALF_SIZE);
    connectors.push([cX, mY, cX, mY + HALF_SIZE]);
    if (pX !== cX)
        connectors.push([Math.min(pX, cX), mY, Math.max(pX, cX), mY]);
    return connectors;
});
export const parents = (families) => (families
    .filter(withType("parent"))
    .reduce((connectors, family) => (connectors.concat(family.parents.reduce(calcConnectors(family), []))), []));
//# sourceMappingURL=parents.js.map
