"""empty message

Revision ID: 4355d25e861c
Revises: e5da1546a4f7
Create Date: 2022-09-22 19:58:09.673579

"""
import sqlalchemy as sa
from alembic import op
from sqlalchemy.dialects import postgresql

# revision identifiers, used by Alembic.
revision = '4355d25e861c'
down_revision = 'e5da1546a4f7'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_unique_constraint(None, 'files', ['id'])
    op.add_column('users', sa.Column('avatar_id', postgresql.UUID(), nullable=True))
    op.create_foreign_key(None, 'users', 'files', ['avatar_id'], ['id'])
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_constraint(None, 'users', type_='foreignkey')
    op.drop_column('users', 'avatar_id')
    op.drop_constraint(None, 'files', type_='unique')
    # ### end Alembic commands ###
