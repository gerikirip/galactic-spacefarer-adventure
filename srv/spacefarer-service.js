const cds = require('@sap/cds');

const checkPositiveNumber = (value, fieldName, req) => {
    if (value <= 0) 
        req.error(400, `${fieldName} must be a positive number!`);
};

const checkSpaceSuitColors = (validSpaceSuitColors, spaceSuitColor, req) => {
    if (!validSpaceSuitColors.includes(spaceSuitColor)) 
        req.error(400, `Invalid spacesuit color! Valid colors are: ${validSpaceSuitColors.join(', ')}`);
};

const ensureExists = async (entity, id, req, label = entity) => {
    const record = await SELECT.one.from(entity).where({ ID: id });
    if (!record) req.error(404, `${label} with ID "${id}" not found!`);
};

module.exports = class SpacefarerService extends cds.ApplicationService {
    init() {
        const validSpaceSuitColors = Object.keys(cds.model.definitions['SpaceSuitColor'].enum);

        this.before('CREATE', 'Spacefarers', async (req) => {
            const {
                userName,
                stardustCollection,
                wormholeNavigationSkill,
                spaceSuitColor,
                department_ID,
                position_ID
            } = req.data;

            checkSpaceSuitColors(validSpaceSuitColors, spaceSuitColor, req);
            checkPositiveNumber(stardustCollection, 'Stardust Collection', req);
            checkPositiveNumber(wormholeNavigationSkill, 'Wormhole Navigation Skill', req);

            const existingUserName = await SELECT.one.from('Spacefarers').where({ userName: userName });
            if (existingUserName) req.error(409, 'User name already exists!');

            await ensureExists('Departments', department_ID, req, 'Department');
            await ensureExists('Positions', position_ID, req, 'Position');
        });
        this.after('CREATE', 'Spacefarers', (data, req) => {
            const { name } = req.data;
            req.notify(200, `Welcome aboard, ${name}! Your cosmic journey among the stars begins now!`);
        });

        this.before('UPDATE', 'Spacefarers', (req) => {
            const {
                stardustCollection,
                spaceSuitColor
            } = req.data;

            checkSpaceSuitColors(validSpaceSuitColors, spaceSuitColor, req);
            checkPositiveNumber(stardustCollection, 'Stardust Collection', req);
        });
        this.after('UPDATE', 'Spacefarers', (data, req) => {
            req.notify(200, `Update was successful!`);
        });

        return super.init();
    }
}