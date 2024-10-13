"""empty message

Revision ID: a33b19f3f3b9
Revises: c80a25e0fcb9
Create Date: 2024-04-19 09:03:34.293727

"""
import sqlalchemy as sa
from alembic import op

# revision identifiers, used by Alembic.
revision = 'a33b19f3f3b9'
down_revision = 'c80a25e0fcb9'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('ascents', schema=None) as batch_op:
        batch_op.alter_column('ascent_date',
                              existing_type=sa.DATE(),
                              nullable=False)

    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('ascents', schema=None) as batch_op:
        batch_op.alter_column('ascent_date',
                              existing_type=sa.DATE(),
                              nullable=True)

    # ### end Alembic commands ###
