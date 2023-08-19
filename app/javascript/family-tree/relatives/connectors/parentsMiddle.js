import { nodeCount } from 'family-tree/relatives/utils/units';
import { getParentsX, withType } from 'family-tree/relatives/utils/family';
import { HALF_SIZE, NODES_IN_COUPLE } from 'family-tree/relatives/constants';

const calcConnectors = (family) => ((connectors, unit) => {
    const pX = getParentsX(family, unit);
    const pY = family.Y + HALF_SIZE;
    if (nodeCount(unit) === NODES_IN_COUPLE)
        connectors.push([pX - HALF_SIZE, pY, pX + HALF_SIZE, pY, unit.nodes[0].spouses[0].type]);
    return connectors;
});
export const parentsMiddle = (families) => (families
    .filter(withType("parent"))
    .reduce((connectors, family) => (connectors.concat(family.parents.reduce(calcConnectors(family), []))), []));
//# sourceMappingURL=parentsMiddle.js.map
