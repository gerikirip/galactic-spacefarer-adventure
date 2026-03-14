const cds = require('@sap/cds');

module.exports = class SpacefarerService extends cds.ApplicationService {
    init() {
        this.before('CREATE', 'Spacefarers', async (req) => {
            const {
                name,
                userName,
                originPlanet, 
                stardustCollection, 
                wormholeNavigationSkill,
                spaceSuitColor, 
                departmentName, 
                positionName,
            } = req.data;

            const isEmpty = (value) => !value || value.trim() === '';
            if (isEmpty(name)) req.error(400, 'Name is required!');
            if (isEmpty(originPlanet)) req.error(400, 'Origin planet is required!');
            if (isEmpty(userName)) req.error(400, 'User name is required!');

            const validSpaceSuitColors = Object.keys(cds.model.definitions['SpaceSuitColor'].enum);
            if (!validSpaceSuitColors.includes(spaceSuitColor)) req.error(400, `Invalid spacesuit color! Valid colors are: ${validSpaceSuitColors.join(', ')}`);

            const isPositiveNumber = (value) => value > 0;
            if (!isPositiveNumber(stardustCollection)) req.error(400, 'Stardust Collection must be a positive number!');
            if (!isPositiveNumber(wormholeNavigationSkill)) req.error(400, 'Wormhole Navigation Skill must be a positive number!');
            
            const existing = await SELECT.one.from('Spacefarers').where({ userName: userName });
            if (existing) req.error(409, 'User name already exists!');

            this.departments = await SELECT.from('Departments');
            const department = this.departments.find(d => d.name === departmentName);
            if (!department) {
                req.reject(404, `Department not found! Available departments: ${this.departments.map(d => d.name).join(', ')}`)
                return;
            }

            this.positions = await SELECT.from('Positions');
            const position = this.positions.find(p => p.name === positionName);
            if (!position) {
                req.reject(404, `Position not found! Available positions: ${this.departments.map(d => d.name).join(', ')}`)
                return;
            }
            
            Object.assign(req.data, {
                department_ID: department.ID,
                position_ID: position.ID
            });
        });
        this.after('CREATE', 'Spacefarers', (data, req) => {
            const { name } = req.data;
            req.notify(200, `Welcome aboard, ${name}! Your cosmic journey among the stars begins now!`)
        });

        return super.init();
    }
}