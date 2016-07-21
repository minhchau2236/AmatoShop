using System;

namespace PSCPortal.CMS.Amato
{
    public delegate void ProtletProductsDisplayDelegate(object sender, ProtletProductsDisplayArgs args);
    [Serializable]
    public class ProtletProductsDisplayArgs : EventArgs
    {
        private readonly ProtletProductsDisplay _protletProductsDisplay;
        public ProtletProductsDisplay ProtletProductsDisplay
        {
            get
            {
                return _protletProductsDisplay;
            }
        }
        private readonly bool _isEdit;
        public bool IsEdit
        {
            get
            {
                return _isEdit;
            }
        }
        public ProtletProductsDisplayArgs(ProtletProductsDisplay protletProductsDisplay, bool isEdit)
        {
            _protletProductsDisplay = protletProductsDisplay;
            _isEdit = isEdit;
        }
    }
}