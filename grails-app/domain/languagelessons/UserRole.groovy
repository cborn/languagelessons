package languagelessons

import grails.gorm.DetachedCriteria
import groovy.transform.ToString

import org.apache.commons.lang.builder.HashCodeBuilder

@ToString(cache=true, includeNames=true, includePackage=false)
class UserRole implements Serializable {

	private static final long serialVersionUID = 1

	SecUser secUser
	Role role

	@Override
	boolean equals(other) {
		if (other instanceof UserRole) {
			other.secUserId == secUser?.id && other.roleId == role?.id
		}
	}

	@Override
	int hashCode() {
		def builder = new HashCodeBuilder()
		if (secUser) builder.append(secUser.id)
		if (role) builder.append(role.id)
		builder.toHashCode()
	}

	static UserRole get(long secUserId, long roleId) {
		criteriaFor(secUserId, roleId).get()
	}

	static boolean exists(long secUserId, long roleId) {
		criteriaFor(secUserId, roleId).count()
	}

	private static DetachedCriteria criteriaFor(long secUserId, long roleId) {
		UserRole.where {
			secUser == SecUser.load(secUserId) &&
			role == Role.load(roleId)
		}
	}

	static UserRole create(SecUser secUser, Role role) {
		def instance = new UserRole(secUser: secUser, role: role)
		instance.save()
		instance
	}

	static boolean remove(SecUser u, Role r) {
		if (u != null && r != null) {
			UserRole.where { secUser == u && role == r }.deleteAll()
		}
	}

	static int removeAll(SecUser u) {
		u == null ? 0 : UserRole.where { secUser == u }.deleteAll()
	}

	static int removeAll(Role r) {
		r == null ? 0 : UserRole.where { role == r }.deleteAll()
	}

	static constraints = {
		role validator: { Role r, UserRole ur ->
			if (ur.secUser?.id) {
				UserRole.withNewSession {
					if (UserRole.exists(ur.secUser.id, r.id)) {
						return ['userRole.exists']
					}
				}
			}
		}
	}

	static mapping = {
		id composite: ['secUser', 'role']
		version false
	}
}