import Store from 'family-tree/relatives/store';
import { placeholders } from 'family-tree/relatives/middle/placeholders';
import { inMiddleDirection } from 'family-tree/relatives/middle';
import { inParentDirection } from 'family-tree/relatives/parents';
import { inChildDirection } from 'family-tree/relatives/children';
import { connectors } from 'family-tree/relatives/connectors';
import { middleAddOns } from 'family-tree/relatives/connectors';
import { correctPositions } from 'family-tree/relatives/utils/correctPositions';
import { getCanvasSize } from 'family-tree/relatives/utils/getCanvasSize';
import { getExtendedNodes } from 'family-tree/relatives/utils/getExtendedNodes';
import { pipe } from 'family-tree/relatives/utils/methods';

const calcFamilies = pipe(inMiddleDirection, inParentDirection, inChildDirection, correctPositions);
export default (nodes, options) => {
    const store = new Store(nodes, options.rootId);
    if (options.placeholders)
        placeholders(store);
    const families = calcFamilies(store).familiesArray;
    return {
        families: families,
        canvas: getCanvasSize(families),
        nodes: getExtendedNodes(families),
        connectors: connectors(families),
        middleAddOns: middleAddOns(families)
    };
};
//# sourceMappingURL=index.js.map
