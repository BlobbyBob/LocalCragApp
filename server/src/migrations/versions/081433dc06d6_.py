"""empty message

Revision ID: 081433dc06d6
Revises: 244e1996b205
Create Date: 2024-04-21 23:34:45.457309

"""
import sqlalchemy as sa
from alembic import op

# revision identifiers, used by Alembic.
revision = '081433dc06d6'
down_revision = '244e1996b205'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('rankings', schema=None) as batch_op:
        batch_op.add_column(sa.Column('top_10_fa_exponential', sa.Integer(), nullable=True))

    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('rankings', schema=None) as batch_op:
        batch_op.drop_column('top_10_fa_exponential')

    # ### end Alembic commands ###
