using { Spacefarers as Spacefarers_, Departments as Departments_, Positions as Positions_ } from '../db/schema';

service SpacefarerService {
    @restrict: [
        { grant: '*', to: 'galactic-commander' },
        { grant: 'READ', to: 'authenticated-user', where: 'userName = $user' }
    ]
    entity Spacefarers as projection on Spacefarers_ {
        ID, name, userName, stardustCollection, wormholeNavigationSkill, originPlanet, spaceSuitColor,
        department.ID as department_ID, department.name as departmentName, position.ID as position_ID, 
        position.name as positionName
    };
    @readonly entity Departments as projection on Departments_;
    @readonly entity Positions   as projection on Positions_;
}
